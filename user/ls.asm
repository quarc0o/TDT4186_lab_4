
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  10:	00000097          	auipc	ra,0x0
  14:	728080e7          	jalr	1832(ra) # 738 <strlen>
  18:	02051793          	slli	a5,a0,0x20
  1c:	9381                	srli	a5,a5,0x20
  1e:	97a6                	add	a5,a5,s1
  20:	02f00693          	li	a3,47
  24:	0097e963          	bltu	a5,s1,36 <fmtname+0x36>
  28:	0007c703          	lbu	a4,0(a5)
  2c:	00d70563          	beq	a4,a3,36 <fmtname+0x36>
  30:	17fd                	addi	a5,a5,-1
  32:	fe97fbe3          	bgeu	a5,s1,28 <fmtname+0x28>
    ;
  p++;
  36:	00178493          	addi	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  3a:	8526                	mv	a0,s1
  3c:	00000097          	auipc	ra,0x0
  40:	6fc080e7          	jalr	1788(ra) # 738 <strlen>
  44:	2501                	sext.w	a0,a0
  46:	47b5                	li	a5,13
  48:	00a7fa63          	bgeu	a5,a0,5c <fmtname+0x5c>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  4c:	8526                	mv	a0,s1
  4e:	70a2                	ld	ra,40(sp)
  50:	7402                	ld	s0,32(sp)
  52:	64e2                	ld	s1,24(sp)
  54:	6942                	ld	s2,16(sp)
  56:	69a2                	ld	s3,8(sp)
  58:	6145                	addi	sp,sp,48
  5a:	8082                	ret
  memmove(buf, p, strlen(p));
  5c:	8526                	mv	a0,s1
  5e:	00000097          	auipc	ra,0x0
  62:	6da080e7          	jalr	1754(ra) # 738 <strlen>
  66:	00001997          	auipc	s3,0x1
  6a:	fba98993          	addi	s3,s3,-70 # 1020 <buf.0>
  6e:	0005061b          	sext.w	a2,a0
  72:	85a6                	mv	a1,s1
  74:	854e                	mv	a0,s3
  76:	00001097          	auipc	ra,0x1
  7a:	834080e7          	jalr	-1996(ra) # 8aa <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  7e:	8526                	mv	a0,s1
  80:	00000097          	auipc	ra,0x0
  84:	6b8080e7          	jalr	1720(ra) # 738 <strlen>
  88:	0005091b          	sext.w	s2,a0
  8c:	8526                	mv	a0,s1
  8e:	00000097          	auipc	ra,0x0
  92:	6aa080e7          	jalr	1706(ra) # 738 <strlen>
  96:	1902                	slli	s2,s2,0x20
  98:	02095913          	srli	s2,s2,0x20
  9c:	4639                	li	a2,14
  9e:	9e09                	subw	a2,a2,a0
  a0:	02000593          	li	a1,32
  a4:	01298533          	add	a0,s3,s2
  a8:	00000097          	auipc	ra,0x0
  ac:	6ba080e7          	jalr	1722(ra) # 762 <memset>
  return buf;
  b0:	84ce                	mv	s1,s3
  b2:	bf69                	j	4c <fmtname+0x4c>

00000000000000b4 <ls>:

void
ls(char *path)
{
  b4:	d9010113          	addi	sp,sp,-624
  b8:	26113423          	sd	ra,616(sp)
  bc:	26813023          	sd	s0,608(sp)
  c0:	24913c23          	sd	s1,600(sp)
  c4:	25213823          	sd	s2,592(sp)
  c8:	25313423          	sd	s3,584(sp)
  cc:	25413023          	sd	s4,576(sp)
  d0:	23513c23          	sd	s5,568(sp)
  d4:	1c80                	addi	s0,sp,624
  d6:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  d8:	4581                	li	a1,0
  da:	00001097          	auipc	ra,0x1
  de:	8c2080e7          	jalr	-1854(ra) # 99c <open>
  e2:	06054f63          	bltz	a0,160 <ls+0xac>
  e6:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  e8:	d9840593          	addi	a1,s0,-616
  ec:	00001097          	auipc	ra,0x1
  f0:	8c8080e7          	jalr	-1848(ra) # 9b4 <fstat>
  f4:	08054163          	bltz	a0,176 <ls+0xc2>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  f8:	da041783          	lh	a5,-608(s0)
  fc:	4705                	li	a4,1
  fe:	08e78c63          	beq	a5,a4,196 <ls+0xe2>
 102:	37f9                	addiw	a5,a5,-2
 104:	17c2                	slli	a5,a5,0x30
 106:	93c1                	srli	a5,a5,0x30
 108:	02f76663          	bltu	a4,a5,134 <ls+0x80>
  case T_DEVICE:
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
 10c:	854a                	mv	a0,s2
 10e:	00000097          	auipc	ra,0x0
 112:	ef2080e7          	jalr	-270(ra) # 0 <fmtname>
 116:	85aa                	mv	a1,a0
 118:	da843703          	ld	a4,-600(s0)
 11c:	d9c42683          	lw	a3,-612(s0)
 120:	da041603          	lh	a2,-608(s0)
 124:	00001517          	auipc	a0,0x1
 128:	d8c50513          	addi	a0,a0,-628 # eb0 <malloc+0x11c>
 12c:	00001097          	auipc	ra,0x1
 130:	bb0080e7          	jalr	-1104(ra) # cdc <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 134:	8526                	mv	a0,s1
 136:	00001097          	auipc	ra,0x1
 13a:	84e080e7          	jalr	-1970(ra) # 984 <close>
}
 13e:	26813083          	ld	ra,616(sp)
 142:	26013403          	ld	s0,608(sp)
 146:	25813483          	ld	s1,600(sp)
 14a:	25013903          	ld	s2,592(sp)
 14e:	24813983          	ld	s3,584(sp)
 152:	24013a03          	ld	s4,576(sp)
 156:	23813a83          	ld	s5,568(sp)
 15a:	27010113          	addi	sp,sp,624
 15e:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 160:	864a                	mv	a2,s2
 162:	00001597          	auipc	a1,0x1
 166:	d1e58593          	addi	a1,a1,-738 # e80 <malloc+0xec>
 16a:	4509                	li	a0,2
 16c:	00001097          	auipc	ra,0x1
 170:	b42080e7          	jalr	-1214(ra) # cae <fprintf>
    return;
 174:	b7e9                	j	13e <ls+0x8a>
    fprintf(2, "ls: cannot stat %s\n", path);
 176:	864a                	mv	a2,s2
 178:	00001597          	auipc	a1,0x1
 17c:	d2058593          	addi	a1,a1,-736 # e98 <malloc+0x104>
 180:	4509                	li	a0,2
 182:	00001097          	auipc	ra,0x1
 186:	b2c080e7          	jalr	-1236(ra) # cae <fprintf>
    close(fd);
 18a:	8526                	mv	a0,s1
 18c:	00000097          	auipc	ra,0x0
 190:	7f8080e7          	jalr	2040(ra) # 984 <close>
    return;
 194:	b76d                	j	13e <ls+0x8a>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 196:	854a                	mv	a0,s2
 198:	00000097          	auipc	ra,0x0
 19c:	5a0080e7          	jalr	1440(ra) # 738 <strlen>
 1a0:	2541                	addiw	a0,a0,16
 1a2:	20000793          	li	a5,512
 1a6:	00a7fb63          	bgeu	a5,a0,1bc <ls+0x108>
      printf("ls: path too long\n");
 1aa:	00001517          	auipc	a0,0x1
 1ae:	d1650513          	addi	a0,a0,-746 # ec0 <malloc+0x12c>
 1b2:	00001097          	auipc	ra,0x1
 1b6:	b2a080e7          	jalr	-1238(ra) # cdc <printf>
      break;
 1ba:	bfad                	j	134 <ls+0x80>
    strcpy(buf, path);
 1bc:	85ca                	mv	a1,s2
 1be:	dc040513          	addi	a0,s0,-576
 1c2:	00000097          	auipc	ra,0x0
 1c6:	52e080e7          	jalr	1326(ra) # 6f0 <strcpy>
    p = buf+strlen(buf);
 1ca:	dc040513          	addi	a0,s0,-576
 1ce:	00000097          	auipc	ra,0x0
 1d2:	56a080e7          	jalr	1386(ra) # 738 <strlen>
 1d6:	1502                	slli	a0,a0,0x20
 1d8:	9101                	srli	a0,a0,0x20
 1da:	dc040793          	addi	a5,s0,-576
 1de:	00a78933          	add	s2,a5,a0
    *p++ = '/';
 1e2:	00190993          	addi	s3,s2,1
 1e6:	02f00793          	li	a5,47
 1ea:	00f90023          	sb	a5,0(s2)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 1ee:	00001a17          	auipc	s4,0x1
 1f2:	ceaa0a13          	addi	s4,s4,-790 # ed8 <malloc+0x144>
        printf("ls: cannot stat %s\n", buf);
 1f6:	00001a97          	auipc	s5,0x1
 1fa:	ca2a8a93          	addi	s5,s5,-862 # e98 <malloc+0x104>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1fe:	a801                	j	20e <ls+0x15a>
        printf("ls: cannot stat %s\n", buf);
 200:	dc040593          	addi	a1,s0,-576
 204:	8556                	mv	a0,s5
 206:	00001097          	auipc	ra,0x1
 20a:	ad6080e7          	jalr	-1322(ra) # cdc <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 20e:	4641                	li	a2,16
 210:	db040593          	addi	a1,s0,-592
 214:	8526                	mv	a0,s1
 216:	00000097          	auipc	ra,0x0
 21a:	75e080e7          	jalr	1886(ra) # 974 <read>
 21e:	47c1                	li	a5,16
 220:	f0f51ae3          	bne	a0,a5,134 <ls+0x80>
      if(de.inum == 0)
 224:	db045783          	lhu	a5,-592(s0)
 228:	d3fd                	beqz	a5,20e <ls+0x15a>
      memmove(p, de.name, DIRSIZ);
 22a:	4639                	li	a2,14
 22c:	db240593          	addi	a1,s0,-590
 230:	854e                	mv	a0,s3
 232:	00000097          	auipc	ra,0x0
 236:	678080e7          	jalr	1656(ra) # 8aa <memmove>
      p[DIRSIZ] = 0;
 23a:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 23e:	d9840593          	addi	a1,s0,-616
 242:	dc040513          	addi	a0,s0,-576
 246:	00000097          	auipc	ra,0x0
 24a:	5d6080e7          	jalr	1494(ra) # 81c <stat>
 24e:	fa0549e3          	bltz	a0,200 <ls+0x14c>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 252:	dc040513          	addi	a0,s0,-576
 256:	00000097          	auipc	ra,0x0
 25a:	daa080e7          	jalr	-598(ra) # 0 <fmtname>
 25e:	85aa                	mv	a1,a0
 260:	da843703          	ld	a4,-600(s0)
 264:	d9c42683          	lw	a3,-612(s0)
 268:	da041603          	lh	a2,-608(s0)
 26c:	8552                	mv	a0,s4
 26e:	00001097          	auipc	ra,0x1
 272:	a6e080e7          	jalr	-1426(ra) # cdc <printf>
 276:	bf61                	j	20e <ls+0x15a>

0000000000000278 <main>:

int
main(int argc, char *argv[])
{
 278:	1101                	addi	sp,sp,-32
 27a:	ec06                	sd	ra,24(sp)
 27c:	e822                	sd	s0,16(sp)
 27e:	e426                	sd	s1,8(sp)
 280:	e04a                	sd	s2,0(sp)
 282:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 284:	4785                	li	a5,1
 286:	02a7d963          	bge	a5,a0,2b8 <main+0x40>
 28a:	00858493          	addi	s1,a1,8
 28e:	ffe5091b          	addiw	s2,a0,-2
 292:	02091793          	slli	a5,s2,0x20
 296:	01d7d913          	srli	s2,a5,0x1d
 29a:	05c1                	addi	a1,a1,16
 29c:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 29e:	6088                	ld	a0,0(s1)
 2a0:	00000097          	auipc	ra,0x0
 2a4:	e14080e7          	jalr	-492(ra) # b4 <ls>
  for(i=1; i<argc; i++)
 2a8:	04a1                	addi	s1,s1,8
 2aa:	ff249ae3          	bne	s1,s2,29e <main+0x26>
  exit(0);
 2ae:	4501                	li	a0,0
 2b0:	00000097          	auipc	ra,0x0
 2b4:	6ac080e7          	jalr	1708(ra) # 95c <exit>
    ls(".");
 2b8:	00001517          	auipc	a0,0x1
 2bc:	c3050513          	addi	a0,a0,-976 # ee8 <malloc+0x154>
 2c0:	00000097          	auipc	ra,0x0
 2c4:	df4080e7          	jalr	-524(ra) # b4 <ls>
    exit(0);
 2c8:	4501                	li	a0,0
 2ca:	00000097          	auipc	ra,0x0
 2ce:	692080e7          	jalr	1682(ra) # 95c <exit>

00000000000002d2 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
 2d2:	1141                	addi	sp,sp,-16
 2d4:	e422                	sd	s0,8(sp)
 2d6:	0800                	addi	s0,sp,16
    lk->name = name;
 2d8:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
 2da:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
 2de:	57fd                	li	a5,-1
 2e0:	00f50823          	sb	a5,16(a0)
}
 2e4:	6422                	ld	s0,8(sp)
 2e6:	0141                	addi	sp,sp,16
 2e8:	8082                	ret

00000000000002ea <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
 2ea:	00054783          	lbu	a5,0(a0)
 2ee:	e399                	bnez	a5,2f4 <holding+0xa>
 2f0:	4501                	li	a0,0
}
 2f2:	8082                	ret
{
 2f4:	1101                	addi	sp,sp,-32
 2f6:	ec06                	sd	ra,24(sp)
 2f8:	e822                	sd	s0,16(sp)
 2fa:	e426                	sd	s1,8(sp)
 2fc:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
 2fe:	01054483          	lbu	s1,16(a0)
 302:	00000097          	auipc	ra,0x0
 306:	340080e7          	jalr	832(ra) # 642 <twhoami>
 30a:	2501                	sext.w	a0,a0
 30c:	40a48533          	sub	a0,s1,a0
 310:	00153513          	seqz	a0,a0
}
 314:	60e2                	ld	ra,24(sp)
 316:	6442                	ld	s0,16(sp)
 318:	64a2                	ld	s1,8(sp)
 31a:	6105                	addi	sp,sp,32
 31c:	8082                	ret

000000000000031e <acquire>:

void acquire(struct lock *lk)
{
 31e:	7179                	addi	sp,sp,-48
 320:	f406                	sd	ra,40(sp)
 322:	f022                	sd	s0,32(sp)
 324:	ec26                	sd	s1,24(sp)
 326:	e84a                	sd	s2,16(sp)
 328:	e44e                	sd	s3,8(sp)
 32a:	e052                	sd	s4,0(sp)
 32c:	1800                	addi	s0,sp,48
 32e:	8a2a                	mv	s4,a0
    if (holding(lk))
 330:	00000097          	auipc	ra,0x0
 334:	fba080e7          	jalr	-70(ra) # 2ea <holding>
 338:	e919                	bnez	a0,34e <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 33a:	ffca7493          	andi	s1,s4,-4
 33e:	003a7913          	andi	s2,s4,3
 342:	0039191b          	slliw	s2,s2,0x3
 346:	4985                	li	s3,1
 348:	012999bb          	sllw	s3,s3,s2
 34c:	a015                	j	370 <acquire+0x52>
        printf("re-acquiring lock we already hold");
 34e:	00001517          	auipc	a0,0x1
 352:	ba250513          	addi	a0,a0,-1118 # ef0 <malloc+0x15c>
 356:	00001097          	auipc	ra,0x1
 35a:	986080e7          	jalr	-1658(ra) # cdc <printf>
        exit(-1);
 35e:	557d                	li	a0,-1
 360:	00000097          	auipc	ra,0x0
 364:	5fc080e7          	jalr	1532(ra) # 95c <exit>
    {
        // give up the cpu for other threads
        tyield();
 368:	00000097          	auipc	ra,0x0
 36c:	258080e7          	jalr	600(ra) # 5c0 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 370:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 374:	0127d7bb          	srlw	a5,a5,s2
 378:	0ff7f793          	zext.b	a5,a5
 37c:	f7f5                	bnez	a5,368 <acquire+0x4a>
    }

    __sync_synchronize();
 37e:	0ff0000f          	fence

    lk->tid = twhoami();
 382:	00000097          	auipc	ra,0x0
 386:	2c0080e7          	jalr	704(ra) # 642 <twhoami>
 38a:	00aa0823          	sb	a0,16(s4)
}
 38e:	70a2                	ld	ra,40(sp)
 390:	7402                	ld	s0,32(sp)
 392:	64e2                	ld	s1,24(sp)
 394:	6942                	ld	s2,16(sp)
 396:	69a2                	ld	s3,8(sp)
 398:	6a02                	ld	s4,0(sp)
 39a:	6145                	addi	sp,sp,48
 39c:	8082                	ret

000000000000039e <release>:

void release(struct lock *lk)
{
 39e:	1101                	addi	sp,sp,-32
 3a0:	ec06                	sd	ra,24(sp)
 3a2:	e822                	sd	s0,16(sp)
 3a4:	e426                	sd	s1,8(sp)
 3a6:	1000                	addi	s0,sp,32
 3a8:	84aa                	mv	s1,a0
    if (!holding(lk))
 3aa:	00000097          	auipc	ra,0x0
 3ae:	f40080e7          	jalr	-192(ra) # 2ea <holding>
 3b2:	c11d                	beqz	a0,3d8 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 3b4:	57fd                	li	a5,-1
 3b6:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 3ba:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 3be:	0ff0000f          	fence
 3c2:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 3c6:	00000097          	auipc	ra,0x0
 3ca:	1fa080e7          	jalr	506(ra) # 5c0 <tyield>
}
 3ce:	60e2                	ld	ra,24(sp)
 3d0:	6442                	ld	s0,16(sp)
 3d2:	64a2                	ld	s1,8(sp)
 3d4:	6105                	addi	sp,sp,32
 3d6:	8082                	ret
        printf("releasing lock we are not holding");
 3d8:	00001517          	auipc	a0,0x1
 3dc:	b4050513          	addi	a0,a0,-1216 # f18 <malloc+0x184>
 3e0:	00001097          	auipc	ra,0x1
 3e4:	8fc080e7          	jalr	-1796(ra) # cdc <printf>
        exit(-1);
 3e8:	557d                	li	a0,-1
 3ea:	00000097          	auipc	ra,0x0
 3ee:	572080e7          	jalr	1394(ra) # 95c <exit>

00000000000003f2 <tinit>:
    func(arg);
    current_thread->state = EXITED;
    tsched();
}

void tinit() {
 3f2:	1141                	addi	sp,sp,-16
 3f4:	e406                	sd	ra,8(sp)
 3f6:	e022                	sd	s0,0(sp)
 3f8:	0800                	addi	s0,sp,16
    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 3fa:	09800513          	li	a0,152
 3fe:	00001097          	auipc	ra,0x1
 402:	996080e7          	jalr	-1642(ra) # d94 <malloc>

    main_thread->tid = next_tid;
 406:	00001797          	auipc	a5,0x1
 40a:	bfa78793          	addi	a5,a5,-1030 # 1000 <next_tid>
 40e:	4398                	lw	a4,0(a5)
 410:	00e50023          	sb	a4,0(a0)
    next_tid += 1;
 414:	4398                	lw	a4,0(a5)
 416:	2705                	addiw	a4,a4,1
 418:	c398                	sw	a4,0(a5)
    main_thread->state = RUNNING;
 41a:	4791                	li	a5,4
 41c:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 41e:	00001797          	auipc	a5,0x1
 422:	bea7b923          	sd	a0,-1038(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 426:	00001797          	auipc	a5,0x1
 42a:	c0a78793          	addi	a5,a5,-1014 # 1030 <threads>
 42e:	00001717          	auipc	a4,0x1
 432:	c8270713          	addi	a4,a4,-894 # 10b0 <base>
        threads[i] = NULL;
 436:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 43a:	07a1                	addi	a5,a5,8
 43c:	fee79de3          	bne	a5,a4,436 <tinit+0x44>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 440:	00001797          	auipc	a5,0x1
 444:	bea7b823          	sd	a0,-1040(a5) # 1030 <threads>
}
 448:	60a2                	ld	ra,8(sp)
 44a:	6402                	ld	s0,0(sp)
 44c:	0141                	addi	sp,sp,16
 44e:	8082                	ret

0000000000000450 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 450:	00001517          	auipc	a0,0x1
 454:	bc053503          	ld	a0,-1088(a0) # 1010 <current_thread>
 458:	00001717          	auipc	a4,0x1
 45c:	bd870713          	addi	a4,a4,-1064 # 1030 <threads>
    for (int i = 0; i < 16; i++) {
 460:	4781                	li	a5,0
 462:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 464:	6314                	ld	a3,0(a4)
 466:	00a68763          	beq	a3,a0,474 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 46a:	2785                	addiw	a5,a5,1
 46c:	0721                	addi	a4,a4,8
 46e:	fec79be3          	bne	a5,a2,464 <tsched+0x14>
    int current_index = 0;
 472:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 474:	0017869b          	addiw	a3,a5,1
 478:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 47c:	00001817          	auipc	a6,0x1
 480:	bb480813          	addi	a6,a6,-1100 # 1030 <threads>
 484:	488d                	li	a7,3
 486:	a021                	j	48e <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 488:	2685                	addiw	a3,a3,1
 48a:	04c68363          	beq	a3,a2,4d0 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 48e:	41f6d71b          	sraiw	a4,a3,0x1f
 492:	01c7571b          	srliw	a4,a4,0x1c
 496:	00d707bb          	addw	a5,a4,a3
 49a:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 49c:	9f99                	subw	a5,a5,a4
 49e:	078e                	slli	a5,a5,0x3
 4a0:	97c2                	add	a5,a5,a6
 4a2:	638c                	ld	a1,0(a5)
 4a4:	d1f5                	beqz	a1,488 <tsched+0x38>
 4a6:	5dbc                	lw	a5,120(a1)
 4a8:	ff1790e3          	bne	a5,a7,488 <tsched+0x38>
{
 4ac:	1141                	addi	sp,sp,-16
 4ae:	e406                	sd	ra,8(sp)
 4b0:	e022                	sd	s0,0(sp)
 4b2:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 4b4:	00001797          	auipc	a5,0x1
 4b8:	b4b7be23          	sd	a1,-1188(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 4bc:	05a1                	addi	a1,a1,8
 4be:	0521                	addi	a0,a0,8
 4c0:	00000097          	auipc	ra,0x0
 4c4:	19a080e7          	jalr	410(ra) # 65a <tswtch>
        //printf("Thread switch complete\n");
    }
}
 4c8:	60a2                	ld	ra,8(sp)
 4ca:	6402                	ld	s0,0(sp)
 4cc:	0141                	addi	sp,sp,16
 4ce:	8082                	ret
 4d0:	8082                	ret

00000000000004d2 <thread_wrapper>:
{
 4d2:	1101                	addi	sp,sp,-32
 4d4:	ec06                	sd	ra,24(sp)
 4d6:	e822                	sd	s0,16(sp)
 4d8:	e426                	sd	s1,8(sp)
 4da:	1000                	addi	s0,sp,32
    uint64 *stack_ptr = (uint64 *)current_thread->tcontext.sp;
 4dc:	00001497          	auipc	s1,0x1
 4e0:	b3448493          	addi	s1,s1,-1228 # 1010 <current_thread>
 4e4:	609c                	ld	a5,0(s1)
 4e6:	6b9c                	ld	a5,16(a5)
    func(arg);
 4e8:	6398                	ld	a4,0(a5)
 4ea:	6788                	ld	a0,8(a5)
 4ec:	9702                	jalr	a4
    current_thread->state = EXITED;
 4ee:	609c                	ld	a5,0(s1)
 4f0:	4719                	li	a4,6
 4f2:	dfb8                	sw	a4,120(a5)
    tsched();
 4f4:	00000097          	auipc	ra,0x0
 4f8:	f5c080e7          	jalr	-164(ra) # 450 <tsched>
}
 4fc:	60e2                	ld	ra,24(sp)
 4fe:	6442                	ld	s0,16(sp)
 500:	64a2                	ld	s1,8(sp)
 502:	6105                	addi	sp,sp,32
 504:	8082                	ret

0000000000000506 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 506:	7179                	addi	sp,sp,-48
 508:	f406                	sd	ra,40(sp)
 50a:	f022                	sd	s0,32(sp)
 50c:	ec26                	sd	s1,24(sp)
 50e:	e84a                	sd	s2,16(sp)
 510:	e44e                	sd	s3,8(sp)
 512:	1800                	addi	s0,sp,48
 514:	84aa                	mv	s1,a0
 516:	8932                	mv	s2,a2
 518:	89b6                	mv	s3,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 51a:	09800513          	li	a0,152
 51e:	00001097          	auipc	ra,0x1
 522:	876080e7          	jalr	-1930(ra) # d94 <malloc>
 526:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 528:	478d                	li	a5,3
 52a:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 52c:	609c                	ld	a5,0(s1)
 52e:	0927b423          	sd	s2,136(a5)
    (*thread)->arg = arg;
 532:	609c                	ld	a5,0(s1)
 534:	0937b023          	sd	s3,128(a5)
    (*thread)->tid = next_tid;
 538:	6098                	ld	a4,0(s1)
 53a:	00001797          	auipc	a5,0x1
 53e:	ac678793          	addi	a5,a5,-1338 # 1000 <next_tid>
 542:	4394                	lw	a3,0(a5)
 544:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 548:	4398                	lw	a4,0(a5)
 54a:	2705                	addiw	a4,a4,1
 54c:	c398                	sw	a4,0(a5)
    //(*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
    //(*thread)->tcontext.ra = (uint64)thread_wrapper;

    // Allocate stack memory for the thread
    uint64 stack_top = (uint64)malloc(4096) + 4096;
 54e:	6505                	lui	a0,0x1
 550:	00001097          	auipc	ra,0x1
 554:	844080e7          	jalr	-1980(ra) # d94 <malloc>

    // Place the function pointer and its argument on the top of the stack
    stack_top -= sizeof(uint64);
    *(uint64 *)stack_top = (uint64)arg;
 558:	6785                	lui	a5,0x1
 55a:	00a78733          	add	a4,a5,a0
 55e:	ff373c23          	sd	s3,-8(a4)
    stack_top -= sizeof(uint64);
 562:	17c1                	addi	a5,a5,-16 # ff0 <digits+0x50>
 564:	953e                	add	a0,a0,a5
    *(uint64 *)stack_top = (uint64)func;
 566:	01253023          	sd	s2,0(a0) # 1000 <next_tid>

    (*thread)->tcontext.sp = stack_top;
 56a:	609c                	ld	a5,0(s1)
 56c:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 56e:	609c                	ld	a5,0(s1)
 570:	00000717          	auipc	a4,0x0
 574:	f6270713          	addi	a4,a4,-158 # 4d2 <thread_wrapper>
 578:	e798                	sd	a4,8(a5)

    int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 57a:	00001717          	auipc	a4,0x1
 57e:	ab670713          	addi	a4,a4,-1354 # 1030 <threads>
 582:	4781                	li	a5,0
 584:	4641                	li	a2,16
        if (threads[i] == NULL) {
 586:	6314                	ld	a3,0(a4)
 588:	c29d                	beqz	a3,5ae <tcreate+0xa8>
    for (int i = 0; i < 16; i++) {
 58a:	2785                	addiw	a5,a5,1
 58c:	0721                	addi	a4,a4,8
 58e:	fec79ce3          	bne	a5,a2,586 <tcreate+0x80>
        }
    }

    // If there are already 16 threads, return without creating a new one
    if (!thread_added) {
        free(*thread);
 592:	6088                	ld	a0,0(s1)
 594:	00000097          	auipc	ra,0x0
 598:	77e080e7          	jalr	1918(ra) # d12 <free>
        *thread = NULL;
 59c:	0004b023          	sd	zero,0(s1)
        return;
    }
}
 5a0:	70a2                	ld	ra,40(sp)
 5a2:	7402                	ld	s0,32(sp)
 5a4:	64e2                	ld	s1,24(sp)
 5a6:	6942                	ld	s2,16(sp)
 5a8:	69a2                	ld	s3,8(sp)
 5aa:	6145                	addi	sp,sp,48
 5ac:	8082                	ret
            threads[i] = *thread;
 5ae:	6094                	ld	a3,0(s1)
 5b0:	078e                	slli	a5,a5,0x3
 5b2:	00001717          	auipc	a4,0x1
 5b6:	a7e70713          	addi	a4,a4,-1410 # 1030 <threads>
 5ba:	97ba                	add	a5,a5,a4
 5bc:	e394                	sd	a3,0(a5)
    if (!thread_added) {
 5be:	b7cd                	j	5a0 <tcreate+0x9a>

00000000000005c0 <tyield>:
    return 0;
}


void tyield()
{
 5c0:	1141                	addi	sp,sp,-16
 5c2:	e406                	sd	ra,8(sp)
 5c4:	e022                	sd	s0,0(sp)
 5c6:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 5c8:	00001797          	auipc	a5,0x1
 5cc:	a487b783          	ld	a5,-1464(a5) # 1010 <current_thread>
 5d0:	470d                	li	a4,3
 5d2:	dfb8                	sw	a4,120(a5)
    tsched();
 5d4:	00000097          	auipc	ra,0x0
 5d8:	e7c080e7          	jalr	-388(ra) # 450 <tsched>
}
 5dc:	60a2                	ld	ra,8(sp)
 5de:	6402                	ld	s0,0(sp)
 5e0:	0141                	addi	sp,sp,16
 5e2:	8082                	ret

00000000000005e4 <tjoin>:
{
 5e4:	1101                	addi	sp,sp,-32
 5e6:	ec06                	sd	ra,24(sp)
 5e8:	e822                	sd	s0,16(sp)
 5ea:	e426                	sd	s1,8(sp)
 5ec:	e04a                	sd	s2,0(sp)
 5ee:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 5f0:	00001797          	auipc	a5,0x1
 5f4:	a4078793          	addi	a5,a5,-1472 # 1030 <threads>
 5f8:	00001697          	auipc	a3,0x1
 5fc:	ab868693          	addi	a3,a3,-1352 # 10b0 <base>
 600:	a021                	j	608 <tjoin+0x24>
 602:	07a1                	addi	a5,a5,8
 604:	02d78b63          	beq	a5,a3,63a <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 608:	6384                	ld	s1,0(a5)
 60a:	dce5                	beqz	s1,602 <tjoin+0x1e>
 60c:	0004c703          	lbu	a4,0(s1)
 610:	fea719e3          	bne	a4,a0,602 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 614:	5cb8                	lw	a4,120(s1)
 616:	4799                	li	a5,6
 618:	4919                	li	s2,6
 61a:	02f70263          	beq	a4,a5,63e <tjoin+0x5a>
        tyield();
 61e:	00000097          	auipc	ra,0x0
 622:	fa2080e7          	jalr	-94(ra) # 5c0 <tyield>
    while (target_thread->state != EXITED) {
 626:	5cbc                	lw	a5,120(s1)
 628:	ff279be3          	bne	a5,s2,61e <tjoin+0x3a>
    return 0;
 62c:	4501                	li	a0,0
}
 62e:	60e2                	ld	ra,24(sp)
 630:	6442                	ld	s0,16(sp)
 632:	64a2                	ld	s1,8(sp)
 634:	6902                	ld	s2,0(sp)
 636:	6105                	addi	sp,sp,32
 638:	8082                	ret
        return -1;
 63a:	557d                	li	a0,-1
 63c:	bfcd                	j	62e <tjoin+0x4a>
    return 0;
 63e:	4501                	li	a0,0
 640:	b7fd                	j	62e <tjoin+0x4a>

0000000000000642 <twhoami>:

uint8 twhoami()
{
 642:	1141                	addi	sp,sp,-16
 644:	e422                	sd	s0,8(sp)
 646:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 648:	00001797          	auipc	a5,0x1
 64c:	9c87b783          	ld	a5,-1592(a5) # 1010 <current_thread>
 650:	0007c503          	lbu	a0,0(a5)
 654:	6422                	ld	s0,8(sp)
 656:	0141                	addi	sp,sp,16
 658:	8082                	ret

000000000000065a <tswtch>:
 65a:	00153023          	sd	ra,0(a0)
 65e:	00253423          	sd	sp,8(a0)
 662:	e900                	sd	s0,16(a0)
 664:	ed04                	sd	s1,24(a0)
 666:	03253023          	sd	s2,32(a0)
 66a:	03353423          	sd	s3,40(a0)
 66e:	03453823          	sd	s4,48(a0)
 672:	03553c23          	sd	s5,56(a0)
 676:	05653023          	sd	s6,64(a0)
 67a:	05753423          	sd	s7,72(a0)
 67e:	05853823          	sd	s8,80(a0)
 682:	05953c23          	sd	s9,88(a0)
 686:	07a53023          	sd	s10,96(a0)
 68a:	07b53423          	sd	s11,104(a0)
 68e:	0005b083          	ld	ra,0(a1)
 692:	0085b103          	ld	sp,8(a1)
 696:	6980                	ld	s0,16(a1)
 698:	6d84                	ld	s1,24(a1)
 69a:	0205b903          	ld	s2,32(a1)
 69e:	0285b983          	ld	s3,40(a1)
 6a2:	0305ba03          	ld	s4,48(a1)
 6a6:	0385ba83          	ld	s5,56(a1)
 6aa:	0405bb03          	ld	s6,64(a1)
 6ae:	0485bb83          	ld	s7,72(a1)
 6b2:	0505bc03          	ld	s8,80(a1)
 6b6:	0585bc83          	ld	s9,88(a1)
 6ba:	0605bd03          	ld	s10,96(a1)
 6be:	0685bd83          	ld	s11,104(a1)
 6c2:	8082                	ret

00000000000006c4 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 6c4:	1101                	addi	sp,sp,-32
 6c6:	ec06                	sd	ra,24(sp)
 6c8:	e822                	sd	s0,16(sp)
 6ca:	e426                	sd	s1,8(sp)
 6cc:	e04a                	sd	s2,0(sp)
 6ce:	1000                	addi	s0,sp,32
 6d0:	84aa                	mv	s1,a0
 6d2:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    tinit();
 6d4:	00000097          	auipc	ra,0x0
 6d8:	d1e080e7          	jalr	-738(ra) # 3f2 <tinit>
    // Set the main thread as the first element in the threads array
    threads[0] = main_thread; */
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 6dc:	85ca                	mv	a1,s2
 6de:	8526                	mv	a0,s1
 6e0:	00000097          	auipc	ra,0x0
 6e4:	b98080e7          	jalr	-1128(ra) # 278 <main>
        if (running_threads > 0) {
            tsched(); // Schedule another thread to run
        }
    } */

    exit(res);
 6e8:	00000097          	auipc	ra,0x0
 6ec:	274080e7          	jalr	628(ra) # 95c <exit>

00000000000006f0 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 6f0:	1141                	addi	sp,sp,-16
 6f2:	e422                	sd	s0,8(sp)
 6f4:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 6f6:	87aa                	mv	a5,a0
 6f8:	0585                	addi	a1,a1,1
 6fa:	0785                	addi	a5,a5,1
 6fc:	fff5c703          	lbu	a4,-1(a1)
 700:	fee78fa3          	sb	a4,-1(a5)
 704:	fb75                	bnez	a4,6f8 <strcpy+0x8>
        ;
    return os;
}
 706:	6422                	ld	s0,8(sp)
 708:	0141                	addi	sp,sp,16
 70a:	8082                	ret

000000000000070c <strcmp>:

int strcmp(const char *p, const char *q)
{
 70c:	1141                	addi	sp,sp,-16
 70e:	e422                	sd	s0,8(sp)
 710:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 712:	00054783          	lbu	a5,0(a0)
 716:	cb91                	beqz	a5,72a <strcmp+0x1e>
 718:	0005c703          	lbu	a4,0(a1)
 71c:	00f71763          	bne	a4,a5,72a <strcmp+0x1e>
        p++, q++;
 720:	0505                	addi	a0,a0,1
 722:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 724:	00054783          	lbu	a5,0(a0)
 728:	fbe5                	bnez	a5,718 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 72a:	0005c503          	lbu	a0,0(a1)
}
 72e:	40a7853b          	subw	a0,a5,a0
 732:	6422                	ld	s0,8(sp)
 734:	0141                	addi	sp,sp,16
 736:	8082                	ret

0000000000000738 <strlen>:

uint strlen(const char *s)
{
 738:	1141                	addi	sp,sp,-16
 73a:	e422                	sd	s0,8(sp)
 73c:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 73e:	00054783          	lbu	a5,0(a0)
 742:	cf91                	beqz	a5,75e <strlen+0x26>
 744:	0505                	addi	a0,a0,1
 746:	87aa                	mv	a5,a0
 748:	86be                	mv	a3,a5
 74a:	0785                	addi	a5,a5,1
 74c:	fff7c703          	lbu	a4,-1(a5)
 750:	ff65                	bnez	a4,748 <strlen+0x10>
 752:	40a6853b          	subw	a0,a3,a0
 756:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 758:	6422                	ld	s0,8(sp)
 75a:	0141                	addi	sp,sp,16
 75c:	8082                	ret
    for (n = 0; s[n]; n++)
 75e:	4501                	li	a0,0
 760:	bfe5                	j	758 <strlen+0x20>

0000000000000762 <memset>:

void *
memset(void *dst, int c, uint n)
{
 762:	1141                	addi	sp,sp,-16
 764:	e422                	sd	s0,8(sp)
 766:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 768:	ca19                	beqz	a2,77e <memset+0x1c>
 76a:	87aa                	mv	a5,a0
 76c:	1602                	slli	a2,a2,0x20
 76e:	9201                	srli	a2,a2,0x20
 770:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 774:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 778:	0785                	addi	a5,a5,1
 77a:	fee79de3          	bne	a5,a4,774 <memset+0x12>
    }
    return dst;
}
 77e:	6422                	ld	s0,8(sp)
 780:	0141                	addi	sp,sp,16
 782:	8082                	ret

0000000000000784 <strchr>:

char *
strchr(const char *s, char c)
{
 784:	1141                	addi	sp,sp,-16
 786:	e422                	sd	s0,8(sp)
 788:	0800                	addi	s0,sp,16
    for (; *s; s++)
 78a:	00054783          	lbu	a5,0(a0)
 78e:	cb99                	beqz	a5,7a4 <strchr+0x20>
        if (*s == c)
 790:	00f58763          	beq	a1,a5,79e <strchr+0x1a>
    for (; *s; s++)
 794:	0505                	addi	a0,a0,1
 796:	00054783          	lbu	a5,0(a0)
 79a:	fbfd                	bnez	a5,790 <strchr+0xc>
            return (char *)s;
    return 0;
 79c:	4501                	li	a0,0
}
 79e:	6422                	ld	s0,8(sp)
 7a0:	0141                	addi	sp,sp,16
 7a2:	8082                	ret
    return 0;
 7a4:	4501                	li	a0,0
 7a6:	bfe5                	j	79e <strchr+0x1a>

00000000000007a8 <gets>:

char *
gets(char *buf, int max)
{
 7a8:	711d                	addi	sp,sp,-96
 7aa:	ec86                	sd	ra,88(sp)
 7ac:	e8a2                	sd	s0,80(sp)
 7ae:	e4a6                	sd	s1,72(sp)
 7b0:	e0ca                	sd	s2,64(sp)
 7b2:	fc4e                	sd	s3,56(sp)
 7b4:	f852                	sd	s4,48(sp)
 7b6:	f456                	sd	s5,40(sp)
 7b8:	f05a                	sd	s6,32(sp)
 7ba:	ec5e                	sd	s7,24(sp)
 7bc:	1080                	addi	s0,sp,96
 7be:	8baa                	mv	s7,a0
 7c0:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 7c2:	892a                	mv	s2,a0
 7c4:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 7c6:	4aa9                	li	s5,10
 7c8:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 7ca:	89a6                	mv	s3,s1
 7cc:	2485                	addiw	s1,s1,1
 7ce:	0344d863          	bge	s1,s4,7fe <gets+0x56>
        cc = read(0, &c, 1);
 7d2:	4605                	li	a2,1
 7d4:	faf40593          	addi	a1,s0,-81
 7d8:	4501                	li	a0,0
 7da:	00000097          	auipc	ra,0x0
 7de:	19a080e7          	jalr	410(ra) # 974 <read>
        if (cc < 1)
 7e2:	00a05e63          	blez	a0,7fe <gets+0x56>
        buf[i++] = c;
 7e6:	faf44783          	lbu	a5,-81(s0)
 7ea:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 7ee:	01578763          	beq	a5,s5,7fc <gets+0x54>
 7f2:	0905                	addi	s2,s2,1
 7f4:	fd679be3          	bne	a5,s6,7ca <gets+0x22>
    for (i = 0; i + 1 < max;)
 7f8:	89a6                	mv	s3,s1
 7fa:	a011                	j	7fe <gets+0x56>
 7fc:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 7fe:	99de                	add	s3,s3,s7
 800:	00098023          	sb	zero,0(s3)
    return buf;
}
 804:	855e                	mv	a0,s7
 806:	60e6                	ld	ra,88(sp)
 808:	6446                	ld	s0,80(sp)
 80a:	64a6                	ld	s1,72(sp)
 80c:	6906                	ld	s2,64(sp)
 80e:	79e2                	ld	s3,56(sp)
 810:	7a42                	ld	s4,48(sp)
 812:	7aa2                	ld	s5,40(sp)
 814:	7b02                	ld	s6,32(sp)
 816:	6be2                	ld	s7,24(sp)
 818:	6125                	addi	sp,sp,96
 81a:	8082                	ret

000000000000081c <stat>:

int stat(const char *n, struct stat *st)
{
 81c:	1101                	addi	sp,sp,-32
 81e:	ec06                	sd	ra,24(sp)
 820:	e822                	sd	s0,16(sp)
 822:	e426                	sd	s1,8(sp)
 824:	e04a                	sd	s2,0(sp)
 826:	1000                	addi	s0,sp,32
 828:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 82a:	4581                	li	a1,0
 82c:	00000097          	auipc	ra,0x0
 830:	170080e7          	jalr	368(ra) # 99c <open>
    if (fd < 0)
 834:	02054563          	bltz	a0,85e <stat+0x42>
 838:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 83a:	85ca                	mv	a1,s2
 83c:	00000097          	auipc	ra,0x0
 840:	178080e7          	jalr	376(ra) # 9b4 <fstat>
 844:	892a                	mv	s2,a0
    close(fd);
 846:	8526                	mv	a0,s1
 848:	00000097          	auipc	ra,0x0
 84c:	13c080e7          	jalr	316(ra) # 984 <close>
    return r;
}
 850:	854a                	mv	a0,s2
 852:	60e2                	ld	ra,24(sp)
 854:	6442                	ld	s0,16(sp)
 856:	64a2                	ld	s1,8(sp)
 858:	6902                	ld	s2,0(sp)
 85a:	6105                	addi	sp,sp,32
 85c:	8082                	ret
        return -1;
 85e:	597d                	li	s2,-1
 860:	bfc5                	j	850 <stat+0x34>

0000000000000862 <atoi>:

int atoi(const char *s)
{
 862:	1141                	addi	sp,sp,-16
 864:	e422                	sd	s0,8(sp)
 866:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 868:	00054683          	lbu	a3,0(a0)
 86c:	fd06879b          	addiw	a5,a3,-48
 870:	0ff7f793          	zext.b	a5,a5
 874:	4625                	li	a2,9
 876:	02f66863          	bltu	a2,a5,8a6 <atoi+0x44>
 87a:	872a                	mv	a4,a0
    n = 0;
 87c:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 87e:	0705                	addi	a4,a4,1
 880:	0025179b          	slliw	a5,a0,0x2
 884:	9fa9                	addw	a5,a5,a0
 886:	0017979b          	slliw	a5,a5,0x1
 88a:	9fb5                	addw	a5,a5,a3
 88c:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 890:	00074683          	lbu	a3,0(a4)
 894:	fd06879b          	addiw	a5,a3,-48
 898:	0ff7f793          	zext.b	a5,a5
 89c:	fef671e3          	bgeu	a2,a5,87e <atoi+0x1c>
    return n;
}
 8a0:	6422                	ld	s0,8(sp)
 8a2:	0141                	addi	sp,sp,16
 8a4:	8082                	ret
    n = 0;
 8a6:	4501                	li	a0,0
 8a8:	bfe5                	j	8a0 <atoi+0x3e>

00000000000008aa <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 8aa:	1141                	addi	sp,sp,-16
 8ac:	e422                	sd	s0,8(sp)
 8ae:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 8b0:	02b57463          	bgeu	a0,a1,8d8 <memmove+0x2e>
    {
        while (n-- > 0)
 8b4:	00c05f63          	blez	a2,8d2 <memmove+0x28>
 8b8:	1602                	slli	a2,a2,0x20
 8ba:	9201                	srli	a2,a2,0x20
 8bc:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 8c0:	872a                	mv	a4,a0
            *dst++ = *src++;
 8c2:	0585                	addi	a1,a1,1
 8c4:	0705                	addi	a4,a4,1
 8c6:	fff5c683          	lbu	a3,-1(a1)
 8ca:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 8ce:	fee79ae3          	bne	a5,a4,8c2 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 8d2:	6422                	ld	s0,8(sp)
 8d4:	0141                	addi	sp,sp,16
 8d6:	8082                	ret
        dst += n;
 8d8:	00c50733          	add	a4,a0,a2
        src += n;
 8dc:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 8de:	fec05ae3          	blez	a2,8d2 <memmove+0x28>
 8e2:	fff6079b          	addiw	a5,a2,-1
 8e6:	1782                	slli	a5,a5,0x20
 8e8:	9381                	srli	a5,a5,0x20
 8ea:	fff7c793          	not	a5,a5
 8ee:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 8f0:	15fd                	addi	a1,a1,-1
 8f2:	177d                	addi	a4,a4,-1
 8f4:	0005c683          	lbu	a3,0(a1)
 8f8:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 8fc:	fee79ae3          	bne	a5,a4,8f0 <memmove+0x46>
 900:	bfc9                	j	8d2 <memmove+0x28>

0000000000000902 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 902:	1141                	addi	sp,sp,-16
 904:	e422                	sd	s0,8(sp)
 906:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 908:	ca05                	beqz	a2,938 <memcmp+0x36>
 90a:	fff6069b          	addiw	a3,a2,-1
 90e:	1682                	slli	a3,a3,0x20
 910:	9281                	srli	a3,a3,0x20
 912:	0685                	addi	a3,a3,1
 914:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 916:	00054783          	lbu	a5,0(a0)
 91a:	0005c703          	lbu	a4,0(a1)
 91e:	00e79863          	bne	a5,a4,92e <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 922:	0505                	addi	a0,a0,1
        p2++;
 924:	0585                	addi	a1,a1,1
    while (n-- > 0)
 926:	fed518e3          	bne	a0,a3,916 <memcmp+0x14>
    }
    return 0;
 92a:	4501                	li	a0,0
 92c:	a019                	j	932 <memcmp+0x30>
            return *p1 - *p2;
 92e:	40e7853b          	subw	a0,a5,a4
}
 932:	6422                	ld	s0,8(sp)
 934:	0141                	addi	sp,sp,16
 936:	8082                	ret
    return 0;
 938:	4501                	li	a0,0
 93a:	bfe5                	j	932 <memcmp+0x30>

000000000000093c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 93c:	1141                	addi	sp,sp,-16
 93e:	e406                	sd	ra,8(sp)
 940:	e022                	sd	s0,0(sp)
 942:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 944:	00000097          	auipc	ra,0x0
 948:	f66080e7          	jalr	-154(ra) # 8aa <memmove>
}
 94c:	60a2                	ld	ra,8(sp)
 94e:	6402                	ld	s0,0(sp)
 950:	0141                	addi	sp,sp,16
 952:	8082                	ret

0000000000000954 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 954:	4885                	li	a7,1
 ecall
 956:	00000073          	ecall
 ret
 95a:	8082                	ret

000000000000095c <exit>:
.global exit
exit:
 li a7, SYS_exit
 95c:	4889                	li	a7,2
 ecall
 95e:	00000073          	ecall
 ret
 962:	8082                	ret

0000000000000964 <wait>:
.global wait
wait:
 li a7, SYS_wait
 964:	488d                	li	a7,3
 ecall
 966:	00000073          	ecall
 ret
 96a:	8082                	ret

000000000000096c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 96c:	4891                	li	a7,4
 ecall
 96e:	00000073          	ecall
 ret
 972:	8082                	ret

0000000000000974 <read>:
.global read
read:
 li a7, SYS_read
 974:	4895                	li	a7,5
 ecall
 976:	00000073          	ecall
 ret
 97a:	8082                	ret

000000000000097c <write>:
.global write
write:
 li a7, SYS_write
 97c:	48c1                	li	a7,16
 ecall
 97e:	00000073          	ecall
 ret
 982:	8082                	ret

0000000000000984 <close>:
.global close
close:
 li a7, SYS_close
 984:	48d5                	li	a7,21
 ecall
 986:	00000073          	ecall
 ret
 98a:	8082                	ret

000000000000098c <kill>:
.global kill
kill:
 li a7, SYS_kill
 98c:	4899                	li	a7,6
 ecall
 98e:	00000073          	ecall
 ret
 992:	8082                	ret

0000000000000994 <exec>:
.global exec
exec:
 li a7, SYS_exec
 994:	489d                	li	a7,7
 ecall
 996:	00000073          	ecall
 ret
 99a:	8082                	ret

000000000000099c <open>:
.global open
open:
 li a7, SYS_open
 99c:	48bd                	li	a7,15
 ecall
 99e:	00000073          	ecall
 ret
 9a2:	8082                	ret

00000000000009a4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 9a4:	48c5                	li	a7,17
 ecall
 9a6:	00000073          	ecall
 ret
 9aa:	8082                	ret

00000000000009ac <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 9ac:	48c9                	li	a7,18
 ecall
 9ae:	00000073          	ecall
 ret
 9b2:	8082                	ret

00000000000009b4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 9b4:	48a1                	li	a7,8
 ecall
 9b6:	00000073          	ecall
 ret
 9ba:	8082                	ret

00000000000009bc <link>:
.global link
link:
 li a7, SYS_link
 9bc:	48cd                	li	a7,19
 ecall
 9be:	00000073          	ecall
 ret
 9c2:	8082                	ret

00000000000009c4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 9c4:	48d1                	li	a7,20
 ecall
 9c6:	00000073          	ecall
 ret
 9ca:	8082                	ret

00000000000009cc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 9cc:	48a5                	li	a7,9
 ecall
 9ce:	00000073          	ecall
 ret
 9d2:	8082                	ret

00000000000009d4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 9d4:	48a9                	li	a7,10
 ecall
 9d6:	00000073          	ecall
 ret
 9da:	8082                	ret

00000000000009dc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 9dc:	48ad                	li	a7,11
 ecall
 9de:	00000073          	ecall
 ret
 9e2:	8082                	ret

00000000000009e4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 9e4:	48b1                	li	a7,12
 ecall
 9e6:	00000073          	ecall
 ret
 9ea:	8082                	ret

00000000000009ec <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 9ec:	48b5                	li	a7,13
 ecall
 9ee:	00000073          	ecall
 ret
 9f2:	8082                	ret

00000000000009f4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 9f4:	48b9                	li	a7,14
 ecall
 9f6:	00000073          	ecall
 ret
 9fa:	8082                	ret

00000000000009fc <ps>:
.global ps
ps:
 li a7, SYS_ps
 9fc:	48d9                	li	a7,22
 ecall
 9fe:	00000073          	ecall
 ret
 a02:	8082                	ret

0000000000000a04 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 a04:	48dd                	li	a7,23
 ecall
 a06:	00000073          	ecall
 ret
 a0a:	8082                	ret

0000000000000a0c <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 a0c:	48e1                	li	a7,24
 ecall
 a0e:	00000073          	ecall
 ret
 a12:	8082                	ret

0000000000000a14 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 a14:	1101                	addi	sp,sp,-32
 a16:	ec06                	sd	ra,24(sp)
 a18:	e822                	sd	s0,16(sp)
 a1a:	1000                	addi	s0,sp,32
 a1c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 a20:	4605                	li	a2,1
 a22:	fef40593          	addi	a1,s0,-17
 a26:	00000097          	auipc	ra,0x0
 a2a:	f56080e7          	jalr	-170(ra) # 97c <write>
}
 a2e:	60e2                	ld	ra,24(sp)
 a30:	6442                	ld	s0,16(sp)
 a32:	6105                	addi	sp,sp,32
 a34:	8082                	ret

0000000000000a36 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 a36:	7139                	addi	sp,sp,-64
 a38:	fc06                	sd	ra,56(sp)
 a3a:	f822                	sd	s0,48(sp)
 a3c:	f426                	sd	s1,40(sp)
 a3e:	f04a                	sd	s2,32(sp)
 a40:	ec4e                	sd	s3,24(sp)
 a42:	0080                	addi	s0,sp,64
 a44:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 a46:	c299                	beqz	a3,a4c <printint+0x16>
 a48:	0805c963          	bltz	a1,ada <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 a4c:	2581                	sext.w	a1,a1
  neg = 0;
 a4e:	4881                	li	a7,0
 a50:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 a54:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 a56:	2601                	sext.w	a2,a2
 a58:	00000517          	auipc	a0,0x0
 a5c:	54850513          	addi	a0,a0,1352 # fa0 <digits>
 a60:	883a                	mv	a6,a4
 a62:	2705                	addiw	a4,a4,1
 a64:	02c5f7bb          	remuw	a5,a1,a2
 a68:	1782                	slli	a5,a5,0x20
 a6a:	9381                	srli	a5,a5,0x20
 a6c:	97aa                	add	a5,a5,a0
 a6e:	0007c783          	lbu	a5,0(a5)
 a72:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 a76:	0005879b          	sext.w	a5,a1
 a7a:	02c5d5bb          	divuw	a1,a1,a2
 a7e:	0685                	addi	a3,a3,1
 a80:	fec7f0e3          	bgeu	a5,a2,a60 <printint+0x2a>
  if(neg)
 a84:	00088c63          	beqz	a7,a9c <printint+0x66>
    buf[i++] = '-';
 a88:	fd070793          	addi	a5,a4,-48
 a8c:	00878733          	add	a4,a5,s0
 a90:	02d00793          	li	a5,45
 a94:	fef70823          	sb	a5,-16(a4)
 a98:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 a9c:	02e05863          	blez	a4,acc <printint+0x96>
 aa0:	fc040793          	addi	a5,s0,-64
 aa4:	00e78933          	add	s2,a5,a4
 aa8:	fff78993          	addi	s3,a5,-1
 aac:	99ba                	add	s3,s3,a4
 aae:	377d                	addiw	a4,a4,-1
 ab0:	1702                	slli	a4,a4,0x20
 ab2:	9301                	srli	a4,a4,0x20
 ab4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 ab8:	fff94583          	lbu	a1,-1(s2)
 abc:	8526                	mv	a0,s1
 abe:	00000097          	auipc	ra,0x0
 ac2:	f56080e7          	jalr	-170(ra) # a14 <putc>
  while(--i >= 0)
 ac6:	197d                	addi	s2,s2,-1
 ac8:	ff3918e3          	bne	s2,s3,ab8 <printint+0x82>
}
 acc:	70e2                	ld	ra,56(sp)
 ace:	7442                	ld	s0,48(sp)
 ad0:	74a2                	ld	s1,40(sp)
 ad2:	7902                	ld	s2,32(sp)
 ad4:	69e2                	ld	s3,24(sp)
 ad6:	6121                	addi	sp,sp,64
 ad8:	8082                	ret
    x = -xx;
 ada:	40b005bb          	negw	a1,a1
    neg = 1;
 ade:	4885                	li	a7,1
    x = -xx;
 ae0:	bf85                	j	a50 <printint+0x1a>

0000000000000ae2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 ae2:	715d                	addi	sp,sp,-80
 ae4:	e486                	sd	ra,72(sp)
 ae6:	e0a2                	sd	s0,64(sp)
 ae8:	fc26                	sd	s1,56(sp)
 aea:	f84a                	sd	s2,48(sp)
 aec:	f44e                	sd	s3,40(sp)
 aee:	f052                	sd	s4,32(sp)
 af0:	ec56                	sd	s5,24(sp)
 af2:	e85a                	sd	s6,16(sp)
 af4:	e45e                	sd	s7,8(sp)
 af6:	e062                	sd	s8,0(sp)
 af8:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 afa:	0005c903          	lbu	s2,0(a1)
 afe:	18090c63          	beqz	s2,c96 <vprintf+0x1b4>
 b02:	8aaa                	mv	s5,a0
 b04:	8bb2                	mv	s7,a2
 b06:	00158493          	addi	s1,a1,1
  state = 0;
 b0a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 b0c:	02500a13          	li	s4,37
 b10:	4b55                	li	s6,21
 b12:	a839                	j	b30 <vprintf+0x4e>
        putc(fd, c);
 b14:	85ca                	mv	a1,s2
 b16:	8556                	mv	a0,s5
 b18:	00000097          	auipc	ra,0x0
 b1c:	efc080e7          	jalr	-260(ra) # a14 <putc>
 b20:	a019                	j	b26 <vprintf+0x44>
    } else if(state == '%'){
 b22:	01498d63          	beq	s3,s4,b3c <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 b26:	0485                	addi	s1,s1,1
 b28:	fff4c903          	lbu	s2,-1(s1)
 b2c:	16090563          	beqz	s2,c96 <vprintf+0x1b4>
    if(state == 0){
 b30:	fe0999e3          	bnez	s3,b22 <vprintf+0x40>
      if(c == '%'){
 b34:	ff4910e3          	bne	s2,s4,b14 <vprintf+0x32>
        state = '%';
 b38:	89d2                	mv	s3,s4
 b3a:	b7f5                	j	b26 <vprintf+0x44>
      if(c == 'd'){
 b3c:	13490263          	beq	s2,s4,c60 <vprintf+0x17e>
 b40:	f9d9079b          	addiw	a5,s2,-99
 b44:	0ff7f793          	zext.b	a5,a5
 b48:	12fb6563          	bltu	s6,a5,c72 <vprintf+0x190>
 b4c:	f9d9079b          	addiw	a5,s2,-99
 b50:	0ff7f713          	zext.b	a4,a5
 b54:	10eb6f63          	bltu	s6,a4,c72 <vprintf+0x190>
 b58:	00271793          	slli	a5,a4,0x2
 b5c:	00000717          	auipc	a4,0x0
 b60:	3ec70713          	addi	a4,a4,1004 # f48 <malloc+0x1b4>
 b64:	97ba                	add	a5,a5,a4
 b66:	439c                	lw	a5,0(a5)
 b68:	97ba                	add	a5,a5,a4
 b6a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 b6c:	008b8913          	addi	s2,s7,8
 b70:	4685                	li	a3,1
 b72:	4629                	li	a2,10
 b74:	000ba583          	lw	a1,0(s7)
 b78:	8556                	mv	a0,s5
 b7a:	00000097          	auipc	ra,0x0
 b7e:	ebc080e7          	jalr	-324(ra) # a36 <printint>
 b82:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 b84:	4981                	li	s3,0
 b86:	b745                	j	b26 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 b88:	008b8913          	addi	s2,s7,8
 b8c:	4681                	li	a3,0
 b8e:	4629                	li	a2,10
 b90:	000ba583          	lw	a1,0(s7)
 b94:	8556                	mv	a0,s5
 b96:	00000097          	auipc	ra,0x0
 b9a:	ea0080e7          	jalr	-352(ra) # a36 <printint>
 b9e:	8bca                	mv	s7,s2
      state = 0;
 ba0:	4981                	li	s3,0
 ba2:	b751                	j	b26 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 ba4:	008b8913          	addi	s2,s7,8
 ba8:	4681                	li	a3,0
 baa:	4641                	li	a2,16
 bac:	000ba583          	lw	a1,0(s7)
 bb0:	8556                	mv	a0,s5
 bb2:	00000097          	auipc	ra,0x0
 bb6:	e84080e7          	jalr	-380(ra) # a36 <printint>
 bba:	8bca                	mv	s7,s2
      state = 0;
 bbc:	4981                	li	s3,0
 bbe:	b7a5                	j	b26 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 bc0:	008b8c13          	addi	s8,s7,8
 bc4:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 bc8:	03000593          	li	a1,48
 bcc:	8556                	mv	a0,s5
 bce:	00000097          	auipc	ra,0x0
 bd2:	e46080e7          	jalr	-442(ra) # a14 <putc>
  putc(fd, 'x');
 bd6:	07800593          	li	a1,120
 bda:	8556                	mv	a0,s5
 bdc:	00000097          	auipc	ra,0x0
 be0:	e38080e7          	jalr	-456(ra) # a14 <putc>
 be4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 be6:	00000b97          	auipc	s7,0x0
 bea:	3bab8b93          	addi	s7,s7,954 # fa0 <digits>
 bee:	03c9d793          	srli	a5,s3,0x3c
 bf2:	97de                	add	a5,a5,s7
 bf4:	0007c583          	lbu	a1,0(a5)
 bf8:	8556                	mv	a0,s5
 bfa:	00000097          	auipc	ra,0x0
 bfe:	e1a080e7          	jalr	-486(ra) # a14 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 c02:	0992                	slli	s3,s3,0x4
 c04:	397d                	addiw	s2,s2,-1
 c06:	fe0914e3          	bnez	s2,bee <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 c0a:	8be2                	mv	s7,s8
      state = 0;
 c0c:	4981                	li	s3,0
 c0e:	bf21                	j	b26 <vprintf+0x44>
        s = va_arg(ap, char*);
 c10:	008b8993          	addi	s3,s7,8
 c14:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 c18:	02090163          	beqz	s2,c3a <vprintf+0x158>
        while(*s != 0){
 c1c:	00094583          	lbu	a1,0(s2)
 c20:	c9a5                	beqz	a1,c90 <vprintf+0x1ae>
          putc(fd, *s);
 c22:	8556                	mv	a0,s5
 c24:	00000097          	auipc	ra,0x0
 c28:	df0080e7          	jalr	-528(ra) # a14 <putc>
          s++;
 c2c:	0905                	addi	s2,s2,1
        while(*s != 0){
 c2e:	00094583          	lbu	a1,0(s2)
 c32:	f9e5                	bnez	a1,c22 <vprintf+0x140>
        s = va_arg(ap, char*);
 c34:	8bce                	mv	s7,s3
      state = 0;
 c36:	4981                	li	s3,0
 c38:	b5fd                	j	b26 <vprintf+0x44>
          s = "(null)";
 c3a:	00000917          	auipc	s2,0x0
 c3e:	30690913          	addi	s2,s2,774 # f40 <malloc+0x1ac>
        while(*s != 0){
 c42:	02800593          	li	a1,40
 c46:	bff1                	j	c22 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 c48:	008b8913          	addi	s2,s7,8
 c4c:	000bc583          	lbu	a1,0(s7)
 c50:	8556                	mv	a0,s5
 c52:	00000097          	auipc	ra,0x0
 c56:	dc2080e7          	jalr	-574(ra) # a14 <putc>
 c5a:	8bca                	mv	s7,s2
      state = 0;
 c5c:	4981                	li	s3,0
 c5e:	b5e1                	j	b26 <vprintf+0x44>
        putc(fd, c);
 c60:	02500593          	li	a1,37
 c64:	8556                	mv	a0,s5
 c66:	00000097          	auipc	ra,0x0
 c6a:	dae080e7          	jalr	-594(ra) # a14 <putc>
      state = 0;
 c6e:	4981                	li	s3,0
 c70:	bd5d                	j	b26 <vprintf+0x44>
        putc(fd, '%');
 c72:	02500593          	li	a1,37
 c76:	8556                	mv	a0,s5
 c78:	00000097          	auipc	ra,0x0
 c7c:	d9c080e7          	jalr	-612(ra) # a14 <putc>
        putc(fd, c);
 c80:	85ca                	mv	a1,s2
 c82:	8556                	mv	a0,s5
 c84:	00000097          	auipc	ra,0x0
 c88:	d90080e7          	jalr	-624(ra) # a14 <putc>
      state = 0;
 c8c:	4981                	li	s3,0
 c8e:	bd61                	j	b26 <vprintf+0x44>
        s = va_arg(ap, char*);
 c90:	8bce                	mv	s7,s3
      state = 0;
 c92:	4981                	li	s3,0
 c94:	bd49                	j	b26 <vprintf+0x44>
    }
  }
}
 c96:	60a6                	ld	ra,72(sp)
 c98:	6406                	ld	s0,64(sp)
 c9a:	74e2                	ld	s1,56(sp)
 c9c:	7942                	ld	s2,48(sp)
 c9e:	79a2                	ld	s3,40(sp)
 ca0:	7a02                	ld	s4,32(sp)
 ca2:	6ae2                	ld	s5,24(sp)
 ca4:	6b42                	ld	s6,16(sp)
 ca6:	6ba2                	ld	s7,8(sp)
 ca8:	6c02                	ld	s8,0(sp)
 caa:	6161                	addi	sp,sp,80
 cac:	8082                	ret

0000000000000cae <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 cae:	715d                	addi	sp,sp,-80
 cb0:	ec06                	sd	ra,24(sp)
 cb2:	e822                	sd	s0,16(sp)
 cb4:	1000                	addi	s0,sp,32
 cb6:	e010                	sd	a2,0(s0)
 cb8:	e414                	sd	a3,8(s0)
 cba:	e818                	sd	a4,16(s0)
 cbc:	ec1c                	sd	a5,24(s0)
 cbe:	03043023          	sd	a6,32(s0)
 cc2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 cc6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 cca:	8622                	mv	a2,s0
 ccc:	00000097          	auipc	ra,0x0
 cd0:	e16080e7          	jalr	-490(ra) # ae2 <vprintf>
}
 cd4:	60e2                	ld	ra,24(sp)
 cd6:	6442                	ld	s0,16(sp)
 cd8:	6161                	addi	sp,sp,80
 cda:	8082                	ret

0000000000000cdc <printf>:

void
printf(const char *fmt, ...)
{
 cdc:	711d                	addi	sp,sp,-96
 cde:	ec06                	sd	ra,24(sp)
 ce0:	e822                	sd	s0,16(sp)
 ce2:	1000                	addi	s0,sp,32
 ce4:	e40c                	sd	a1,8(s0)
 ce6:	e810                	sd	a2,16(s0)
 ce8:	ec14                	sd	a3,24(s0)
 cea:	f018                	sd	a4,32(s0)
 cec:	f41c                	sd	a5,40(s0)
 cee:	03043823          	sd	a6,48(s0)
 cf2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 cf6:	00840613          	addi	a2,s0,8
 cfa:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 cfe:	85aa                	mv	a1,a0
 d00:	4505                	li	a0,1
 d02:	00000097          	auipc	ra,0x0
 d06:	de0080e7          	jalr	-544(ra) # ae2 <vprintf>
}
 d0a:	60e2                	ld	ra,24(sp)
 d0c:	6442                	ld	s0,16(sp)
 d0e:	6125                	addi	sp,sp,96
 d10:	8082                	ret

0000000000000d12 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 d12:	1141                	addi	sp,sp,-16
 d14:	e422                	sd	s0,8(sp)
 d16:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 d18:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d1c:	00000797          	auipc	a5,0x0
 d20:	2fc7b783          	ld	a5,764(a5) # 1018 <freep>
 d24:	a02d                	j	d4e <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 d26:	4618                	lw	a4,8(a2)
 d28:	9f2d                	addw	a4,a4,a1
 d2a:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 d2e:	6398                	ld	a4,0(a5)
 d30:	6310                	ld	a2,0(a4)
 d32:	a83d                	j	d70 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 d34:	ff852703          	lw	a4,-8(a0)
 d38:	9f31                	addw	a4,a4,a2
 d3a:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 d3c:	ff053683          	ld	a3,-16(a0)
 d40:	a091                	j	d84 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d42:	6398                	ld	a4,0(a5)
 d44:	00e7e463          	bltu	a5,a4,d4c <free+0x3a>
 d48:	00e6ea63          	bltu	a3,a4,d5c <free+0x4a>
{
 d4c:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d4e:	fed7fae3          	bgeu	a5,a3,d42 <free+0x30>
 d52:	6398                	ld	a4,0(a5)
 d54:	00e6e463          	bltu	a3,a4,d5c <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d58:	fee7eae3          	bltu	a5,a4,d4c <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 d5c:	ff852583          	lw	a1,-8(a0)
 d60:	6390                	ld	a2,0(a5)
 d62:	02059813          	slli	a6,a1,0x20
 d66:	01c85713          	srli	a4,a6,0x1c
 d6a:	9736                	add	a4,a4,a3
 d6c:	fae60de3          	beq	a2,a4,d26 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 d70:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 d74:	4790                	lw	a2,8(a5)
 d76:	02061593          	slli	a1,a2,0x20
 d7a:	01c5d713          	srli	a4,a1,0x1c
 d7e:	973e                	add	a4,a4,a5
 d80:	fae68ae3          	beq	a3,a4,d34 <free+0x22>
        p->s.ptr = bp->s.ptr;
 d84:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 d86:	00000717          	auipc	a4,0x0
 d8a:	28f73923          	sd	a5,658(a4) # 1018 <freep>
}
 d8e:	6422                	ld	s0,8(sp)
 d90:	0141                	addi	sp,sp,16
 d92:	8082                	ret

0000000000000d94 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 d94:	7139                	addi	sp,sp,-64
 d96:	fc06                	sd	ra,56(sp)
 d98:	f822                	sd	s0,48(sp)
 d9a:	f426                	sd	s1,40(sp)
 d9c:	f04a                	sd	s2,32(sp)
 d9e:	ec4e                	sd	s3,24(sp)
 da0:	e852                	sd	s4,16(sp)
 da2:	e456                	sd	s5,8(sp)
 da4:	e05a                	sd	s6,0(sp)
 da6:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 da8:	02051493          	slli	s1,a0,0x20
 dac:	9081                	srli	s1,s1,0x20
 dae:	04bd                	addi	s1,s1,15
 db0:	8091                	srli	s1,s1,0x4
 db2:	0014899b          	addiw	s3,s1,1
 db6:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 db8:	00000517          	auipc	a0,0x0
 dbc:	26053503          	ld	a0,608(a0) # 1018 <freep>
 dc0:	c515                	beqz	a0,dec <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 dc2:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 dc4:	4798                	lw	a4,8(a5)
 dc6:	02977f63          	bgeu	a4,s1,e04 <malloc+0x70>
    if (nu < 4096)
 dca:	8a4e                	mv	s4,s3
 dcc:	0009871b          	sext.w	a4,s3
 dd0:	6685                	lui	a3,0x1
 dd2:	00d77363          	bgeu	a4,a3,dd8 <malloc+0x44>
 dd6:	6a05                	lui	s4,0x1
 dd8:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 ddc:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 de0:	00000917          	auipc	s2,0x0
 de4:	23890913          	addi	s2,s2,568 # 1018 <freep>
    if (p == (char *)-1)
 de8:	5afd                	li	s5,-1
 dea:	a895                	j	e5e <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 dec:	00000797          	auipc	a5,0x0
 df0:	2c478793          	addi	a5,a5,708 # 10b0 <base>
 df4:	00000717          	auipc	a4,0x0
 df8:	22f73223          	sd	a5,548(a4) # 1018 <freep>
 dfc:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 dfe:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 e02:	b7e1                	j	dca <malloc+0x36>
            if (p->s.size == nunits)
 e04:	02e48c63          	beq	s1,a4,e3c <malloc+0xa8>
                p->s.size -= nunits;
 e08:	4137073b          	subw	a4,a4,s3
 e0c:	c798                	sw	a4,8(a5)
                p += p->s.size;
 e0e:	02071693          	slli	a3,a4,0x20
 e12:	01c6d713          	srli	a4,a3,0x1c
 e16:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 e18:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 e1c:	00000717          	auipc	a4,0x0
 e20:	1ea73e23          	sd	a0,508(a4) # 1018 <freep>
            return (void *)(p + 1);
 e24:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 e28:	70e2                	ld	ra,56(sp)
 e2a:	7442                	ld	s0,48(sp)
 e2c:	74a2                	ld	s1,40(sp)
 e2e:	7902                	ld	s2,32(sp)
 e30:	69e2                	ld	s3,24(sp)
 e32:	6a42                	ld	s4,16(sp)
 e34:	6aa2                	ld	s5,8(sp)
 e36:	6b02                	ld	s6,0(sp)
 e38:	6121                	addi	sp,sp,64
 e3a:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 e3c:	6398                	ld	a4,0(a5)
 e3e:	e118                	sd	a4,0(a0)
 e40:	bff1                	j	e1c <malloc+0x88>
    hp->s.size = nu;
 e42:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 e46:	0541                	addi	a0,a0,16
 e48:	00000097          	auipc	ra,0x0
 e4c:	eca080e7          	jalr	-310(ra) # d12 <free>
    return freep;
 e50:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 e54:	d971                	beqz	a0,e28 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 e56:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 e58:	4798                	lw	a4,8(a5)
 e5a:	fa9775e3          	bgeu	a4,s1,e04 <malloc+0x70>
        if (p == freep)
 e5e:	00093703          	ld	a4,0(s2)
 e62:	853e                	mv	a0,a5
 e64:	fef719e3          	bne	a4,a5,e56 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 e68:	8552                	mv	a0,s4
 e6a:	00000097          	auipc	ra,0x0
 e6e:	b7a080e7          	jalr	-1158(ra) # 9e4 <sbrk>
    if (p == (char *)-1)
 e72:	fd5518e3          	bne	a0,s5,e42 <malloc+0xae>
                return 0;
 e76:	4501                	li	a0,0
 e78:	bf45                	j	e28 <malloc+0x94>
