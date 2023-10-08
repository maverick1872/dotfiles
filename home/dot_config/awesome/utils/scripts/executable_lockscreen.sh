#!/bin/sh

BLANK='#00000000'
CLEAR='#ffffff22'
DEFAULT='#ff00ffcc'
TEXT='#ee00eeee'
WRONG='#880000bb'
VERIFYING='#bb00bbbb'

i3lock \
--insidever-color=$CLEAR     \
--ringver-color=$VERIFYING   \
\
--insidewrong-color=$CLEAR   \
--ringwrong-color=$WRONG     \
\
--inside-color=$BLANK        \
--ring-color=$DEFAULT        \
--line-color=$BLANK          \
--separator-color=$DEFAULT   \
\
--verif-color=$TEXT          \
--wrong-color=$TEXT          \
--time-color=$TEXT           \
--date-color=$TEXT           \
--layout-color=$TEXT         \
--keyhl-color=$WRONG         \
--bshl-color=$WRONG          \
\
--screen 1                   \
--blur 9                     \
--clock                      \
--indicator                  \
--time-str="%H:%M:%S"        \
--date-str="%A, %Y-%m-%d"       \
--keylayout 1                \
#
# i3lock \
# --blur 5 \
# --bar-indicator \
# --bar-pos y+h \
# --bar-direction 1 \
# --bar-max-height 50 \
# --bar-base-width 50 \
# --bar-color 000000cc \
# --keyhl-color 880088cc \
# --bar-periodic-step 50 \
# --bar-step 50 \
# --redraw-thread \
# \
# --clock \
# --force-clock \
# --time-pos x+5:y+h-80 \
# --time-color 880088ff \
# --date-pos tx:ty+15 \
# --date-color 990099ff \
# --date-align 1 \
# --time-align 1 \
# --ringver-color 8800ff88 \
# --ringwrong-color ff008888 \
# --status-pos x+5:y+h-16 \
# --verif-align 1 \
# --wrong-align 1 \
# --verif-color ffffffff \
# --wrong-color ffffffff \
# --modif-pos -50:-50
