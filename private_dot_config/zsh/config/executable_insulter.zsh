print_message() {

    local messages
    local message

    messages=(
        "Boooo!"
        "I ran your command in a parallel universe. It failed there too."
        "Processing... Nope. Still dumb."
        "Read the man pages bruh"
        "If I had a dollar for every bad command, I'd buy you a real OS."
        "You have no power here, newbie of Bash."
        "Looks like someone's been Ctrl+C-ing from StackOverflow again."
        "Error: Brain not connected to keyboard."
        "Wrong again, command warrior."
        "Don't you know anything?"
        "RTFM!"
        "Haha, n00b!"
        "Wow! That was impressively wrong!"
        "Pathetic"
        "The worst one today!"
        "n00b alert!"
        "Your application for reduced salary has been sent!"
        "lol"
        "u suk"
        "lol... plz"
        "plz uninstall"
        "And the Darwin Award goes to.... ${USER}!"
        "ERROR_INCOMPETENT_USER"
        "Incompetence is also a form of competence"
        "Fake it till you make it!"
        "What is this...? Amateur hour!?"
        "Come on! You can do it!"
        "Nice try."
        "What if... you type an actual command the next time!"
        "What if I told you... it is possible to type valid commands."
        "Y u no speak computer???"
        "This is not Windows"
        "Perhaps you should leave the command line alone..."
        "Please step away from the keyboard!"
        "error code: 1D10T"
        "ACHTUNG! ALLES TURISTEN UND NONTEKNISCHEN LOOKENPEEPERS! DAS KOMPUTERMASCHINE IST NICHT FÜR DER GEFINGERPOKEN UND MITTENGRABEN! ODERWISE IST EASY TO SCHNAPPEN DER SPRINGENWERK, BLOWENFUSEN UND POPPENCORKEN MIT SPITZENSPARKEN. IST NICHT FÜR GEWERKEN BEI DUMMKOPFEN. DER RUBBERNECKEN SIGHTSEEREN KEEPEN DAS COTTONPICKEN HÄNDER IN DAS POCKETS MUSS. ZO RELAXEN UND WATSCHEN DER BLINKENLICHTEN."
        "Pro tip: type a valid command!"
        "Go outside."
        "This is not a search engine."
        "So, I'm just going to go ahead and run rm -rf / for you."
        "Why are you so stupid?!"
        "Perhaps computers is not for you..."
        "Why are you doing this to me?!"
        "Don't you have anything better to do?!"
        "I am _seriously_ considering 'rm -rf /'-ing myself..."
        "This is why you get to see your children only once a month."
        "This is why nobody likes you."
        "Are you even trying?!"
        "Try using your brain the next time!"
        "My keyboard is not a touch screen!"
        "Commands, random gibberish, who cares!"
        "Typing incorrect commands, eh?"
        "Are you always this stupid or are you making a special effort today?!"
        "Dropped on your head as a baby, eh?"
        "Brains aren't everything. In your case they're nothing."
        "I don't know what makes you so stupid, but it really works."
        "You are not as bad as people say, you are much, much worse."
        "Two wrongs don't make a right, take your parents as an example."
        "You must have been born on a highway because that's where most accidents happen."
        "If what you don't know can't hurt you, you're invulnerable."
        "If ignorance is bliss, you must be the happiest person on earth."
        "You're proof that god has a sense of humor."
        "Keep trying, someday you'll do something intelligent!"
        "If shit was music, you'd be an orchestra."
        "How many times do I have to flush before you go away?"
        "Away, you three-inch fool!"
        "Allowing you to survive childbirth was medical malpractice."
        "Even your mom loves you only as a friend."
        "I was going to give you a nasty look, but I see you already have one."
        "If beauty fades then you have nothing to worry about."
        "If brains were gasoline you wouldn't have enough to propel a flea's motorcycle around a doughnut."
        "I'd slap you, but that'd be animal abuse."
        "I've heard of being hit with the ugly stick, but you must have been beaten senseless with it."
        "Let's play horse. I'll be the front end. And you be yourself."
        "Life is good, you should get one."
        "My uptime is longer than your relationships."
        "Perhaps computers are not for you..."
        "Rose are red. Violets are blue. I have five fingers. The middle one's for you."
        "Sorry what? I don't understand idiot language."
        "The degree of your stupidity is enough to boil water."
        "Why did the chicken cross the road? To get the hell away from you."
        "You are not useless since you can still be used as a bad example."
        "You're so dumb your first words were DUH."\
        "You're the reason Santa says ho, ho, ho, on Christmas!"
        "You look smarter in pictures."
        "Honestly, I'm just impressed you could read this."
        "You are an oxygen bandit."
        "I envy everyone who hasn't met you."
        "You're proof that evolution is bulls*it."
        "Our parents told us we could be anything, and you chose "disappointment.""
        "Your birth control of choice appears to be your personality."
        "If zombies tried eating your brains, they'd starve."
        "How did this guy get passed the login screen ?"
        "Billions of years of evolution just to make you"
        "Are you always this stupid, or is this a special occasion?"
        "Go drown in a lake of diet coke you neutered asshole."
        "I don't engage in mental combat with the unarmed."
        "Don't feel bad. A lot of people have no talent!"
         "I ran your command in a parallel universe. It failed there too."
        "Processing... Nope. Still dumb."
        "Read the man pages bruh"
        "If I had a dollar for every bad command, I'd buy you a real OS."
        "You have no power here, newbie of Bash."
        "Looks like someone's been Ctrl+C-ing from StackOverflow again."
        "Error: Brain not connected to keyboard."
        "Wrong again, command warrior."
        "Don't you know anything?"
        "I'm not saying I can't handle it. I'm just saying I won't"
        "The terminal is taking the rest of the day off after that."
        "One small typo for man, one giant WTF for bash."
        "Not only did that fail, but it also hurt my feelings."
        "I'm going to pretend I didn't see that."
        "I've seen better input from a cat walking on a keyboard."
        "I ran that command, and now I need a drink."
        "Congratulations, you've made me wish I was a Windows terminal."
        "You know, there are people who actually pay to be this incompetent."
        "I tried to execute that... and now I'm haunted."
        "I don't know what you were trying to do, but it didn't work."
        "I'm not angry. Just disappointed."
        "I could explain why that failed, but I want you to grow."
        "Somewhere, Linus Torvalds just facepalmed."
        "You've angered the sysadmin gods. Sacrifice a rubber chicken."
        "My circuits weep everytime you press Enter."
        "That command was so bad, I felt it in my fan speeds."
        "Your shell history will be used as evidence."
        "Achievement unlocked: Expert in Confusion."
        "Your keyboard might be haunted."
        "That command is now being taught in a course titled "What Not to Bash""
        "Command not recognized. But hey, points for creatvity."
        "I fed that to ChatGPT. It threw it back and said "No thanks.""
    )

    # If CMD_NOT_FOUND_MSGS array is populated use those messages instead of the defaults
    [[ -n ${CMD_NOT_FOUND_MSGS} ]] && messages=("${CMD_NOT_FOUND_MSGS[@]}")

    # If CMD_NOT_FOUND_MSGS_APPEND array is populated append those to the existing messages
    [[ -n ${CMD_NOT_FOUND_MSGS_APPEND} ]] && messages+=("${CMD_NOT_FOUND_MSGS_APPEND[@]}")

    # Seed RANDOM with an integer of some length
    RANDOM=$(od -vAn -N4 -tu </dev/urandom)

    # Print a randomly selected message, but only about half the time to annoy the user a
    # little bit less.
    # if [[ $((${RANDOM} % 2)) -lt 1 ]]; then
        message=${messages[${RANDOM} % ${#messages[@]}]}
        printf "\\n  %s\\n\\n" "$(tput bold)$(tput setaf 1)${message}$(tput sgr0)" >&2
    # fi
}

function_exists() {
    # Zsh returns 0 even on non existing functions with -F so use -f
    declare -f $1 >/dev/null
    return $?
}

#
# The idea below is to copy any existing handlers to another function
# name and insert the message in front of the old handler in the
# new handler. By default, neither bash or zsh has has a handler function
# defined, so the default behavior is replicated.
#
# Also, ensure the handler is only copied once. If we do not ensure this
# the handler would add itself recursively if this file happens to be
# sourced multiple times in the same shell, resulting in a neverending
# stream of messages.
#

#
# Zsh
#
if function_exists command_not_found_handler; then
    if ! function_exists orig_command_not_found_handler; then
        eval "orig_$(declare -f command_not_found_handler)"
    fi
else
    orig_command_not_found_handler() {
        printf "zsh: command not found: %s\\n" "$1" >&2
        return 127
    }
fi

command_not_found_handler() {
    print_message
    orig_command_not_found_handler "$@"
}

#
# Bash
#
if function_exists command_not_found_handle; then
    if ! function_exists orig_command_not_found_handle; then
        eval "orig_$(declare -f command_not_found_handle)"
    fi
else
    orig_command_not_found_handle() {
        printf "%s: %s: command not found\\n" "$0" "$1" >&2
        return 127
    }
fi

command_not_found_handle() {
    print_message
    orig_command_not_found_handle "$@"
}
