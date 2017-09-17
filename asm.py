rfile=open(raw_input('Enter filename: ')+'.dlx',"r")
wfile=open("inst_dump.txt","w")
for line in rfile:
 line=line.split(' ')
 if line[0]=='addi': opcode ="010000" 
 if line[0]=='subi': opcode ="010010"
 if line[0]=='lw': opcode ="000101"
 if line[0]=='sw': opcode ="001010"
 
 if line[0]=='addi' or line[0]=='subi'or line[0]=='sw'or line[0]=='lw': 
  
  line[1]=line[1].split('r')  
  line[2]=line[2].split('r')
  regs='{0:05b}'.format(int(line[1][1]))
  regd='{0:05b}'.format(int(line[2][1]))
  imm='{0:016b}'.format(int(line[3]))
  inst=str(opcode)+str(regs)+str(regd)+str(imm)
  print inst
  wfile.write(inst+"\n");

 
