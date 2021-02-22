#! /usr/bin/env bash
##################
# OPTIONS SECTION
##################
bold=$(tput bold)
normal=$(tput sgr0)

origin=""
destination=""

if [ $# -eq 0 ]
then
    printf "\n%s\t\t%s\n\n" "Use ${bold}-h${normal} for help."
     exit 1
else
    while getopts ":h" option
    do
        case ${option} in
            h )
                printf "\n%s\t\t%s\n\n" "Usage:   ./syncFolder.sh ${bold}/origin/folder${normal} -o ${bold}/destination/folder${normal}"
                exit 0
            ;;
            \? )
                printf "\n%s\n\n" "${bold}Invalid Option for${normal} $(basename $0)" 1>&2
                exit 1
            ;;
        esac
    done
    shift $((OPTIND -1))
    origin=$1
    shift
    while getopts ":o:" option
    do
        case ${option} in
            o )
                destination=$OPTARG
                printf "\n%s\n\n" "The following folders will be left-right synced:"
                printf "\tOrigen:\t\t\t%s\n" "${bold}$origin${normal}"
                printf "\tDestination:\t\t%s\n\n" "${bold}$destination${normal}"
            ;;
            \? )
                printf "\n%s\n\n" "${bold}Invalid Option for${normal} $(basename $0): -$OPTARG." 1>&2
                exit 1
            ;;
            : )
                printf "\n%s\n\n" "${bold}The option${normal} -$OPTARG requires a directory as argument." 1>&2
                exit 1
            ;;
            * )
                printf "\n%s\n\n" "${bold}Unkown option for${normal} $(basename $0): -$OPTARG." 1>&2
                exit 1
            ;;
        esac
    done
shift $((OPTIND -1))
fi

##################
# SYNC SECTION
##################

while inotifywait -r -e modify,create,delete $origin
do
     rsync -avz $origin/ $destination --delete --filter='P .git'
done
