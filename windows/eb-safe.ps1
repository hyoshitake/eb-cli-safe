If($Args[0] -eq "ssh"){
  # SSHコマンドの場合
  
  # eb listの結果に"*"がある環境名を取得する。
  $cursor_env = [string](eb list | Out-String -Stream | Select-String "\*")
  
  # 環境名の先頭の"* "を削除する
  $cursor_env = $cursor_env.Substring(2);
  
  # 表示して標準入力を待つ
  Write-Host -BackgroundColor Black -ForegroundColor Red  "接続先環境：${cursor_env}"
  $input = Read-Host "${cursor_env}にアクセスしますか？(Y/n)"
  
  # 入力データがYの時だけ元のコマンドを実行する
  If($input -eq "Y"){
    Invoke-Expression "eb $Args"
  }
  
}ElseIf($Args[0] -eq "deploy"){
  # deployコマンドの場合
  
  # gitのログを表示
  Write-Host ""
  Write-Host "--現在利用中のブランチ------------"
  git log -n 1
  Write-Host "----------------------------------"
  
  # eb listの結果に"*"がある環境名を取得する。
  $cursor_env = [string](eb list | Out-String -Stream | Select-String "\*")
  
  # 環境名の先頭の"* "を削除する
  $cursor_env = $cursor_env.Substring(2);
  
  # 表示して標準入力を待つ
  Write-Host -BackgroundColor Black -ForegroundColor Red  "接続先環境：${cursor_env}"
  $input = Read-Host "${cursor_env}にデプロイしますか？(Y/n)"

  # 入力データがYの時だけ元のコマンドを実行する
  If($input -eq "Y"){
    # proが入っている環境にデプロイしようとしている場合はもう一回確認する
    $cursor_env = [string](eb list | Out-String -Stream | Select-String "\*" | Select-String "pro")
    If($cursor_env.Length -ne 0){
    
      # 再確認
      $input = Read-Host "本番環境へのデプロイです。間違いないですか？(Y/n)"
      If($input -eq "Y"){
      	Write-Host $Args
        Invoke-Expression "eb $Args"
      }
    }Else{
      Invoke-Expression "eb $Args"
    }
    
  }
}Else{
  # その他のコマンドは普通に実行
  Invoke-Expression "eb $Args"
}