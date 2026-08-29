#!/usr/bin/env python3
"""
Convert Outlook .msg email files to plain-text .txt files.

Usage:
    uv run outlook_to_txt.py INPUT_FOLDER OUTPUT

Separate files:
    uv run outlook_to_txt.py ./outlook_export ./ai_emails

From another folder:
    uv run --project /path/to/outlook-to-txt /path/to/outlook-to-txt/outlook_to_txt.py --single-file ./outlook_export ./all_emails.txt

Single combined file:
    uv run outlook_to_txt.py --single-file ./outlook_export ./all_emails.txt
"""

import argparse
import re
from pathlib import Path

import extract_msg


def safe_filename(name: str, max_length: int = 120) -> str:
    """Make a string safe to use as a filename."""
    name = re.sub(r'[<>:"/\\|?*\x00-\x1f]', "_", name)
    name = re.sub(r"\s+", " ", name).strip()
    return name[:max_length] or "email"


def extract_email(msg_path: Path) -> tuple[str, str]:
    """Extract an Outlook .msg file and return its subject and text."""
    msg = extract_msg.Message(str(msg_path))

    try:
        subject = msg.subject or "(No Subject)"
        sender = msg.sender or ""
        recipients = msg.to or ""
        cc = msg.cc or ""
        date = str(msg.date or "")
        body = msg.body or ""

        text = f"""SUBJECT: {subject}
FROM: {sender}
TO: {recipients}
CC: {cc}
DATE: {date}
SOURCE_FILE: {msg_path.name}

-------------------- EMAIL BODY --------------------

{body.strip()}
"""

        return subject, text

    finally:
        msg.close()


def write_separate_files(msg_files: list[Path], output_dir: Path) -> None:
    """Write each email to a separate text file."""
    output_dir.mkdir(parents=True, exist_ok=True)

    for msg_path in msg_files:
        try:
            subject, text = extract_email(msg_path)

            filename = (
                safe_filename(msg_path.stem)
                + " - "
                + safe_filename(subject, 80)
                + ".txt"
            )

            output_path = output_dir / filename

            counter = 2
            while output_path.exists():
                filename = (
                    safe_filename(msg_path.stem)
                    + " - "
                    + safe_filename(subject, 70)
                    + f" ({counter}).txt"
                )
                output_path = output_dir / filename
                counter += 1

            output_path.write_text(text, encoding="utf-8")
            print(f"OK: {msg_path.name} -> {output_path.name}")

        except Exception as e:  # noqa: BLE001
            print(f"ERROR: {msg_path}: {e}")


def write_single_file(msg_files: list[Path], output_file: Path) -> None:
    """Write all emails to a single text file."""
    output_file.parent.mkdir(parents=True, exist_ok=True)

    separator = "\n\n" + "=" * 80 + "\n\n"

    with output_file.open("w", encoding="utf-8") as f:
        for msg_path in msg_files:
            try:
                _, text = extract_email(msg_path)
                f.write(text)
                f.write(separator)
                print(f"OK: {msg_path.name}")

            except Exception as e:  # noqa: BLE001
                print(f"ERROR: {msg_path}: {e}")

    print(f"\nCombined output: {output_file}")


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Convert Outlook .msg files to plain text."
    )

    parser.add_argument(
        "input",
        type=Path,
        help="Folder containing .msg files",
    )

    parser.add_argument(
        "output",
        type=Path,
        help="Output folder, or .txt file when using --single-file",
    )

    parser.add_argument(
        "--single-file",
        action="store_true",
        help="Combine all emails into one text file",
    )

    args = parser.parse_args()

    input_path = args.input.expanduser().resolve()
    output_path = args.output.expanduser().resolve()

    if not input_path.is_dir():
        parser.error(f"Input folder does not exist: {input_path}")

    msg_files = sorted(input_path.rglob("*.msg"))

    if not msg_files:
        print(f"No .msg files found in: {input_path}")
        return

    print(f"Found {len(msg_files)} Outlook messages.\n")

    if args.single_file:
        write_single_file(msg_files, output_path)
    else:
        write_separate_files(msg_files, output_path)

    print(f"\nFinished. Processed {len(msg_files)} messages.")


if __name__ == "__main__":
    main()
