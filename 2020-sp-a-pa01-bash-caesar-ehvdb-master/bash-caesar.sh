#!/bin/bash

#message=$(cat $1)
message=$(head -n 1 $input)

charMessage=$( echo "$message" | fold -w1 )

SYMBOLS="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890 !?."
ARRSYMBOLS=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z 1 2 3 4 5 6 7 8 9 0 \  ! ? .)

symbolsLength="${#SYMBOLS}"

#load dictionary onto array
dict=$(cat dictionary.txt)
dict=( $dict )
# dict=()
# while IFS= read -r line; do
#     dict=("$line" "${dict[@]}")
#     echo "$line"
# done < "$file"

#looping through every possible key in this loop
for (( key=0; key <= symbolsLength; key=key+1)); do
    #reset to blank string as to not keep concatenating
    translated=""
    #goes through every symbol in message
    for (( q = 0 ; q < ${#message} ; q++ )); do
        symbol="${message:q:1}"
        if [[ $SYMBOLS =~ "$symbol" ]]; then
        
            for i in "${!ARRSYMBOLS[@]}"; do
                if [[ "${ARRSYMBOLS[$i]}" = "$symbol" ]]; then
                    symbolIndex="${i}";
                fi
            done
            translatedIndex=$(( symbolIndex - key ))
            
            #handle wrap around:
            if [[ translatedIndex -lt 0 ]]; then
                translatedIndex=$(( translatedIndex + symbolsLength ))
            fi
            
            #append to the translated message:
            translated="$translated${ARRSYMBOLS[$translatedIndex]}"
        
        else
            translated+="$symbol"
        fi
    
    done
    
    #remove everything except letters
    removedStuff="$(sed -e "s/[^ a-zA-Z]//g" -e 's/ \+/ /' <<< "$translated")"
    
    #convert to array
    arrTranslated=( $removedStuff )
    
    #count number of english words
    matches=0
    for j in "${arrTranslated[@]}"; do
        matches=$(( $matches + 1 ))
    done
    
    #if it loads enough words onto array, it will accept english
    if [[ $matches -gt 7 ]]; then
        foundKey="$key"
        break #no longer need to search
    fi
done

#found the key, now translate entire message
echo "$translated"
while IFS= read -r line; do
    translated=""

    for (( j = 0 ; j < ${#line} ; j++ )); do
        symbol="${line:j:1}"
        if [[ $SYMBOLS =~ "$symbol" ]]; then
        
            for i in "${!ARRSYMBOLS[@]}"; do
                if [[ "${ARRSYMBOLS[$i]}" = "$symbol" ]]; then
                    symbolIndex="${i}";
                    break
                fi
            done
            #replace this with "foundKey"
            translatedIndex=$(( symbolIndex - foundKey ))
            
            #handle wrap around:
            if [[ translatedIndex -lt 0 ]]; then
                translatedIndex=$(( translatedIndex + symbolsLength ))
            fi
            
            #append to the translated message:
            translated="$translated${ARRSYMBOLS[$translatedIndex]}"
            
        else
            translated+="$symbol"
        fi

    done
    
    echo "$translated"
done









