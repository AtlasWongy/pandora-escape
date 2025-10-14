TARGET="./target"
BINARY_NAME="pandora-escape"

remove_game_build() {                     
    echo "Removing game build...."        
    if [ -d "$TARGET" ]; then
        if [ "$(ls -A "$TARGET")" ]; then
            echo "Removing content binaries"
            find "$TARGET" -mindepth 1 -delete 
            echo "Contents binary deleted!"
        else
            echo "No content binaries found. Target folder is already empty"
        fi
    else
        echo "Target folder does not exist..."
        # Test this scenario next time
        exit 1
    fi
}

build_game() {                                                   
    echo "Starting game build...."                               
    godot --headless --export-debug "Linux" target/pandora-escape
    echo "Game build sucess!!"
}                                                                
                                                                 
run_game() {                                                     
    echo "Running game build...."
    "$TARGET/$BINARY_NAME" &
    
    while ! swaymsg -t get_tree | grep '"class": "pandora-escape"'; do
        sleep 0.1
    done

    swaymsg '[class="pandora-escape"] floating enable; move position center'
    sleep 1
    swaymsg '[class="pandora-escape"] resize set 1280 720'
    sleep 1
    swaymsg '[class="pandora-escape"] move position center;'
}

debug_game() {
    echo "Debugging the game"
    godot --remote-debug tcp://127.0.0.1:6007 &

    while ! swaymsg -t get_tree | grep '"class": "pandora-escape"'; do
        sleep 0.1
    done

    swaymsg '[class="pandora-escape"] floating enable; move position center'
    sleep 1
    swaymsg '[class="pandora-escape"] resize set 1280 720'
    sleep 1
    swaymsg '[class="pandora-escape"] move position center;'
}

while true; do
    echo -e "Choose build option\n 0.Cancel\n 1.Build\n 2.Build & Run\n 3.Debug Game"
    read -p "Enter the option: " option
    if [[ "$option" == "0" ]]; then
        echo "Cancelling build"
        exit 0
    elif [[ "$option" =~ ^[1-3]+$ ]]; then
        echo "You have chosen: $option"
        remove_game_build
        if [[ "$option" == "1" ]]; then
            build_game
            exit 0
        elif [[ "$option" == "2" ]]; then
            build_game
            run_game
            exit 0
        elif [[ "$option" == "3" ]]; then
            debug_game
            exit 0
        fi
        break
    else
        echo "Invalid option, only give provided option"
    fi
done
