echo "===== Shell configuration ====="
echo "Do you wish to configure your shell? (Yy/Nn)\c"
read -r answer
if [[ $answer != "${answer#[Yy]}" ]]; then
    ./setupShell.sh
else
    echo "Skipping..."
fi

echo ""
echo "===== Git Globals configuration ====="
#TODO: Run a diff against git config if it already exists.
echo "Do you wish to configure git user globals? (Yy/Nn)\c"
read -r answer
if [[ $answer != "${answer#[Yy]}" ]]; then
    cp "${PWD}"/git/config "${HOME}"/.gitconfig
    echo "Copied git user globals to ${HOME}/.gitconfig"
else
    echo "Skipping..."
    echo ""
fi

#TODO: Add setup steps for vim/tmux/screen when desired