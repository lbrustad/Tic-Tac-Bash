#!/bin/bash

# Functions

function drawMap() {
  clear
  echo -e "
  Tic Tac Bash - by Lasse Brustad

    +---+---+---+
    |   |   |   |
    |   |   |   |
    |   |   |   |
    +---+---+---+
    |   |   |   |
    |   |   |   |
    |   |   |   |
    +---+---+---+
    |   |   |   |
    |   |   |   |
    |   |   |   |
    +---+---+---+"
}

function update()
{
  local POSX
  local POSY
  if [ $1 = 1 ]; then
    POSX=7
  elif [ $1 = 2 ]; then
    POSX=11
  elif [ $1 = 3 ]; then
    POSX=15
  fi

  if [ $2 = 1 ]; then
    POSY=6
  elif [ $2 = 2 ]; then
    POSY=10
  elif [ $2 = 3 ]; then
    POSY=14
  fi

  echo -e "\e[$POSY;${POSX}H$3"
}

function main() {
  declare -a X=(0 0 0)
  declare -a Y=(0 0 0)
  declare -a Z=(0 0 0)
  local PLAYER=X
  local UPDATE=0

  drawMap

  while [ 1 -gt 0 ]
  do
    echo -e "\e[18;3HIt's ${PLAYER}'s turn\e[19;1H"
    read -n 1 -p "  X-axis (1/2/3): " IN_X
    echo -e "\e[21;1H"
    read -n 1 -p "  Y-axis (1/2/3): " IN_Y
    if [ 4 -gt $IN_X ] && [ $IN_X -gt 0 ] && [ 4 -gt $IN_Y ] && [ $IN_Y -gt 0 ]; then
      if [ $IN_Y = 1 ] && [[ X[IN_X] -eq 0 ]]; then
        X[${IN_X}] = "$PLAYER"
        UPDATE=1
      elif [ $IN_Y = 2 ] && [[ Y[IN_X] -eq 0 ]]; then
        Y[${IN_X}] = "$PLAYER"
        update $IN_X $IN_Y $PLAYER
        UPDATE=1
      elif [ $IN_Y = 3 ] && [[ Z[IN_X] -eq 0 ]]; then
        Z[${IN_X}] = "$PLAYER"
        update $IN_X $IN_Y $PLAYER
        UPDATE=1
      fi

      if [ $UPDATE = 1 ]; then
        UPDATE=0
        update $IN_X $IN_Y $PLAYER

        if [ $PLAYER = X ]; then
          PLAYER=O
        else
          PLAYER=X
        fi
      else
        echo -e "\e[25;4H\033[31;1mSomething went wrong!\033[m"
        sleep 3
      fi
    fi
      
  done
}

main