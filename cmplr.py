rfile=open(raw_input('Enter filename:')+'.txt',"r")
wfile=open("asm_dump.s","w")
check=0
for line in rfile:
    line=line.strip('\n')
    line=line.strip('\t')
    line=line.split('\t')
    if len(line)<=1:
     line[0]=line[0].split(' ')
     print line
     if line[0][0]=='.cfi_def_cfa_register':
      print 'CHECK'
      check=1
    else:
     line[1]=line[1].split(',')
     if check==1:      
      if(line[0]=='movl'):
       print line
       if line
       if line[1][0][0]=='$':
        line[1][0]=line[1][0].split('$')
       else:
        line[1][0]=line[1][0].split('(')
       line[1][1]=line[1][1].split('(')
       print line[1][1][0]+' '+line[1][0][1]
         
     
     
    
    
