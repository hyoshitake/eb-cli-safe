If($Args[0] -eq "ssh"){
  # SSH�R�}���h�̏ꍇ
  
  # eb list�̌��ʂ�"*"������������擾����B
  $cursor_env = [string](eb list | Out-String -Stream | Select-String "\*")
  
  # �����̐擪��"* "���폜����
  $cursor_env = $cursor_env.Substring(2);
  
  # �\�����ĕW�����͂�҂�
  Write-Host -BackgroundColor Black -ForegroundColor Red  "�ڑ�����F${cursor_env}"
  $input = Read-Host "${cursor_env}�ɃA�N�Z�X���܂����H(Y/n)�F"
  
  # ���̓f�[�^��Y�̎��������̃R�}���h�����s����
  If($input -eq "Y"){
    Invoke-Expression "eb $Args"
  }
  
}ElseIf($Args[0] -eq "deploy"){
  # deploy�R�}���h�̏ꍇ
  
  # git�̃��O��\��
  Write-Host ""
  Write-Host "--���ݗ��p���̃u�����`------------"
  git log -n 1
  Write-Host "----------------------------------"
  
  # eb list�̌��ʂ�"*"������������擾����B
  $cursor_env = [string](eb list | Out-String -Stream | Select-String "\*")
  
  # �����̐擪��"* "���폜����
  $cursor_env = $cursor_env.Substring(2);
  
  # �\�����ĕW�����͂�҂�
  Write-Host -BackgroundColor Black -ForegroundColor Red  "�ڑ�����F${cursor_env}"
  $input = Read-Host "${cursor_env}�Ƀf�v���C���܂����H(Y/n)"
  
  # ���̓f�[�^��Y�̎��������̃R�}���h�����s����
  If($input -eq "Y"){
    # pro�������Ă�����Ƀf�v���C���悤�Ƃ��Ă���ꍇ�͂������m�F����
    $cursor_env = [string](eb list | Out-String -Stream | Select-String "\*" | Select-String "pro")
    If($cursor_env.Length -eq 1){
    
      # �Ċm�F
      $input = Read-Host "�{�Ԋ��ւ̃f�v���C�ł��B�ԈႢ�Ȃ��ł����H(Y/n)"
      If($input -eq "Y"){
        Invoke-Expression "eb $Args"
      }
    }
  }
}