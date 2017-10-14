rfile=open(raw_input('Enter filename:')+'.txt',"r")
wfile=open("inst_dump.txt","w")


############################
def Asm2Mach(line):
 if line[0]=='addi': opcode ="010000" 
 if line[0]=='subi': opcode ="010010"
 if line[0]=='lw': opcode ="000101"
 if line[0]=='sw': opcode ="001010"
 if line[0]=='j': opcode="100100"
 if line[0]=='bnez': opcode="100001"
 if line[0]=="slti": opcode="011010"
 if line[0]=="bqez": opcode="100000"
 if line[0]=="add" : 
  opcode="110000" 
  funccode="00000000001"
 
   
 #For I-type instructions
 if line[0]=='addi' or line[0]=='subi'or line[0]=='sw'or line[0]=='lw' or line[0]=='slti' or line[0]=='bnez' or line[0]=='bqez': 
  
  line[1]=line[1].split('r')  
  line[2]=line[2].split('r')
  regs='{0:05b}'.format(int(line[1][1]))
  regd='{0:05b}'.format(int(line[2][1]))
  imm='{0:016b}'.format(int(line[3]))
  inst=opcode+str(regs)+str(regd)+str(imm)
                     
 #For J-type instrutions
 if line[0]=='j':
  offset='{0:026b}'.format(int(line[1]))
  inst=opcode+str(offset)

 #For R-type instructions 
 if line[0]=='add':
  line[1]=line[1].split('r')  
  line[2]=line[2].split('r')
  line[3]=line[3].split('r')
  regs1='{0:05b}'.format(int(line[1][1]))
  regs2='{0:05b}'.format(int(line[2][1]))
  regd1='{0:05b}'.format(int(line[3][1]))
  inst=opcode+str(regs1)+str(regs2)+str(regd1)+funccode


 return inst

##############################  
		
for line in rfile:
  
 print line
 line=line.strip('\n')
 line=line.split(' ')
 inst1=Asm2Mach(line)
 if inst1:
  print inst1 
  wfile.write(inst1+"\n");  
 
