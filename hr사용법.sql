SELECT *
FROM dba_users;

비밀번호 변경
ALTER user hr identified by java;

계정 lock 해제
ALTER user hr ACCOUNT UNLOCK;