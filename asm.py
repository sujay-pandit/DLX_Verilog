############################ Function#################
def Asm2Mach(line):
 if line[0]=='addi': opcode ="010000" 
 if line[0]=='subi': opcode ="010010"
 if line[0]=='lw': opcode ="000101"
 if line[0]=='sw': opcode ="001010"
 if line[0]=='j': opcode="100100"
 if line[0]=='bnez': opcode="100001"
 if line[0]=="slti": opcode="011010"
 if line[0]=="beqz": opcode="100000"
 if line[0]=="andi": opcode="010100"
 if line[0]=="ori": opcode="010101"
 if line[0]=="xori": opcode="010110"
 if line[0]=="sgti": opcode="011011"
 if line[0]=="sgei": opcode="011100"
 if line[0]=="seqi": opcode="011101"
 if line[0]=="slei": opcode="011110"
 if line[0]=="snei": opcode="011111" 
 if line[0]=="add" : 
  opcode="110000" 
  funccode="00000000001"
 if line[0]=="sub" : 
  opcode="110000" 
  funccode="00000000011"
 if line[0]=="and" : 
  opcode="110000" 
  funccode="00000000101"
 if line[0]=="or" : 
  opcode="110000" 
  funccode="00000000110"
 if line[0]=="xor" : 
  opcode="110000" 
  funccode="00000000111"
 if line[0]=="slt" : 
  opcode="110000" 
  funccode="00000001011"
 if line[0]=="sgt" : 
  opcode="110000" 
  funccode="00000001100"
 if line[0]=="sle" : 
  opcode="110000" 
  funccode="00000001101"
 if line[0]=="sge" : 
  opcode="110000" 
  funccode="00000001110"
 if line[0]=="seq" : 
  opcode="110000" 
  funccode="00000001111"
 if line[0]=="sne" : 
  opcode="110000" 
  funccode="00000010000"
  
   
 #For I-type instructions
 if line[0]=='addi' or line[0]=='subi'or line[0]=='sw'or line[0]=='lw' or line[0]=='slti' or line[0]=='bnez' or line[0]=='beqz' or line[0]=='bnez' or line[0]=="slti" or line[0]=="beqz" or line[0]=="andi"or line[0]=="ori" or line[0]=="xori" or line[0]=="sgti" or line[0]=="sgei" or line[0]=="seqi" or line[0]=="slei" or line[0]=="snei": 
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
 if line[0]=='add' or line[0]=='sub' or line[0]=='and' or line[0]=='or' or line[0]=='xor' or line[0]=='slt' or line[0]=='sgt' or line[0]=='sle' or line[0]=='sge' or line[0]=='seq' or line[0]=='sne':   :
  line[1]=line[1].split('r')  
  line[2]=line[2].split('r')
  line[3]=line[3].split('r')
  regs1='{0:05b}'.format(int(line[1][1]))
  regs2='{0:05b}'.format(int(line[2][1]))
  regd1='{0:05b}'.format(int(line[3][1]))
  inst=opcode+str(regs1)+str(regs2)+str(regd1)+funccode

 return inst

############################## Main ###################################  
rfile=open(raw_input('Enter filename:')+'.txt',"r")
wfile=open("inst_dump.txt","w")		
for line in rfile:  
 print line
 line=line.strip('\n')
 line=line.split(' ')
 inst1=Asm2Mach(line)
 if inst1:
  print inst1 
  wfile.write(inst1+"\n");  
 
