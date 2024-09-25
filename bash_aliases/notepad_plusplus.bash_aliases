open_notepad(){
    echo "Opening notepad++ in the background..."
    notepad++ $1 &
}
alias npp=" open_notepad "