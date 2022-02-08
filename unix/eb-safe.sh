#!/bin/bash

if [ $1 = "ssh" ]; then
  # SSHコマンドの場合
  
  # eb listの結果に"*"がある環境名を取得する。
  cursor_env=$(eb list | grep "*" | head -n 1)
  
  # 環境名の先頭の"* "を削除する
  cursor_env="${cursor_env:2}"
  
  # 表示して標準入力を待つ
  printf '\033[31m%s\033[m\n' "接続先環境：${cursor_env}"
  printf "${cursor_env}にアクセスしますか？(Y/n)："; read input
  
  # 入力データがYの時だけ元のコマンドを実行する
  if [ ${input} = "Y" ]; then
    eb $@
  fi
elif [ $1 = "deploy" ]; then
  # deployコマンドの場合
  
  # gitのログを表示
  echo ""
  echo "--現在利用中のブランチ------------"
  git log -n 1
  echo "----------------------------------"
  
  # eb listの結果に"*"がある環境名を取得する。
  cursor_env=$(eb list | grep "*" | head -n 1)
  
  # 環境名の先頭の"* "を削除する
  cursor_env="${cursor_env:2}"
  
  # 表示して標準入力を待つ
  printf '\033[31m%s\033[m\n' "接続先環境：${cursor_env}"
  printf "${cursor_env}にデプロイしますか？(Y/n)："; read input
  
  # 入力データがYの時だけ元のコマンドを実行する
  if [ ${input} = "Y" ]; then
    # proが入っている環境にデプロイしようとしている場合はもう一回確認する
    cursor_env=$(eb list | grep "*" | grep "pro" | head -n 1)
    if [ ${cursor_env} != "" ]; then
      # 再確認
      printf "本番環境へのデプロイです。間違いないですか？(Y/n)："; read input
      if [ ${input} = "Y" ]; then
        eb $@
      fi
    else
      eb $@
    fi
  fi
else
  eb $@
fi
