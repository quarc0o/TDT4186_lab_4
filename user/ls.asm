
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
  14:	558080e7          	jalr	1368(ra) # 568 <strlen>
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
  40:	52c080e7          	jalr	1324(ra) # 568 <strlen>
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
  62:	50a080e7          	jalr	1290(ra) # 568 <strlen>
  66:	00001997          	auipc	s3,0x1
  6a:	faa98993          	addi	s3,s3,-86 # 1010 <buf.0>
  6e:	0005061b          	sext.w	a2,a0
  72:	85a6                	mv	a1,s1
  74:	854e                	mv	a0,s3
  76:	00000097          	auipc	ra,0x0
  7a:	664080e7          	jalr	1636(ra) # 6da <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  7e:	8526                	mv	a0,s1
  80:	00000097          	auipc	ra,0x0
  84:	4e8080e7          	jalr	1256(ra) # 568 <strlen>
  88:	0005091b          	sext.w	s2,a0
  8c:	8526                	mv	a0,s1
  8e:	00000097          	auipc	ra,0x0
  92:	4da080e7          	jalr	1242(ra) # 568 <strlen>
  96:	1902                	slli	s2,s2,0x20
  98:	02095913          	srli	s2,s2,0x20
  9c:	4639                	li	a2,14
  9e:	9e09                	subw	a2,a2,a0
  a0:	02000593          	li	a1,32
  a4:	01298533          	add	a0,s3,s2
  a8:	00000097          	auipc	ra,0x0
  ac:	4ea080e7          	jalr	1258(ra) # 592 <memset>
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
  da:	00000097          	auipc	ra,0x0
  de:	6f2080e7          	jalr	1778(ra) # 7cc <open>
  e2:	06054f63          	bltz	a0,160 <ls+0xac>
  e6:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  e8:	d9840593          	addi	a1,s0,-616
  ec:	00000097          	auipc	ra,0x0
  f0:	6f8080e7          	jalr	1784(ra) # 7e4 <fstat>
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
 128:	bbc50513          	addi	a0,a0,-1092 # ce0 <malloc+0x11c>
 12c:	00001097          	auipc	ra,0x1
 130:	9e0080e7          	jalr	-1568(ra) # b0c <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 134:	8526                	mv	a0,s1
 136:	00000097          	auipc	ra,0x0
 13a:	67e080e7          	jalr	1662(ra) # 7b4 <close>
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
 166:	b4e58593          	addi	a1,a1,-1202 # cb0 <malloc+0xec>
 16a:	4509                	li	a0,2
 16c:	00001097          	auipc	ra,0x1
 170:	972080e7          	jalr	-1678(ra) # ade <fprintf>
    return;
 174:	b7e9                	j	13e <ls+0x8a>
    fprintf(2, "ls: cannot stat %s\n", path);
 176:	864a                	mv	a2,s2
 178:	00001597          	auipc	a1,0x1
 17c:	b5058593          	addi	a1,a1,-1200 # cc8 <malloc+0x104>
 180:	4509                	li	a0,2
 182:	00001097          	auipc	ra,0x1
 186:	95c080e7          	jalr	-1700(ra) # ade <fprintf>
    close(fd);
 18a:	8526                	mv	a0,s1
 18c:	00000097          	auipc	ra,0x0
 190:	628080e7          	jalr	1576(ra) # 7b4 <close>
    return;
 194:	b76d                	j	13e <ls+0x8a>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 196:	854a                	mv	a0,s2
 198:	00000097          	auipc	ra,0x0
 19c:	3d0080e7          	jalr	976(ra) # 568 <strlen>
 1a0:	2541                	addiw	a0,a0,16
 1a2:	20000793          	li	a5,512
 1a6:	00a7fb63          	bgeu	a5,a0,1bc <ls+0x108>
      printf("ls: path too long\n");
 1aa:	00001517          	auipc	a0,0x1
 1ae:	b4650513          	addi	a0,a0,-1210 # cf0 <malloc+0x12c>
 1b2:	00001097          	auipc	ra,0x1
 1b6:	95a080e7          	jalr	-1702(ra) # b0c <printf>
      break;
 1ba:	bfad                	j	134 <ls+0x80>
    strcpy(buf, path);
 1bc:	85ca                	mv	a1,s2
 1be:	dc040513          	addi	a0,s0,-576
 1c2:	00000097          	auipc	ra,0x0
 1c6:	35e080e7          	jalr	862(ra) # 520 <strcpy>
    p = buf+strlen(buf);
 1ca:	dc040513          	addi	a0,s0,-576
 1ce:	00000097          	auipc	ra,0x0
 1d2:	39a080e7          	jalr	922(ra) # 568 <strlen>
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
 1f2:	b1aa0a13          	addi	s4,s4,-1254 # d08 <malloc+0x144>
        printf("ls: cannot stat %s\n", buf);
 1f6:	00001a97          	auipc	s5,0x1
 1fa:	ad2a8a93          	addi	s5,s5,-1326 # cc8 <malloc+0x104>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1fe:	a801                	j	20e <ls+0x15a>
        printf("ls: cannot stat %s\n", buf);
 200:	dc040593          	addi	a1,s0,-576
 204:	8556                	mv	a0,s5
 206:	00001097          	auipc	ra,0x1
 20a:	906080e7          	jalr	-1786(ra) # b0c <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 20e:	4641                	li	a2,16
 210:	db040593          	addi	a1,s0,-592
 214:	8526                	mv	a0,s1
 216:	00000097          	auipc	ra,0x0
 21a:	58e080e7          	jalr	1422(ra) # 7a4 <read>
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
 236:	4a8080e7          	jalr	1192(ra) # 6da <memmove>
      p[DIRSIZ] = 0;
 23a:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 23e:	d9840593          	addi	a1,s0,-616
 242:	dc040513          	addi	a0,s0,-576
 246:	00000097          	auipc	ra,0x0
 24a:	406080e7          	jalr	1030(ra) # 64c <stat>
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
 272:	89e080e7          	jalr	-1890(ra) # b0c <printf>
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
 2b4:	4dc080e7          	jalr	1244(ra) # 78c <exit>
    ls(".");
 2b8:	00001517          	auipc	a0,0x1
 2bc:	a6050513          	addi	a0,a0,-1440 # d18 <malloc+0x154>
 2c0:	00000097          	auipc	ra,0x0
 2c4:	df4080e7          	jalr	-524(ra) # b4 <ls>
    exit(0);
 2c8:	4501                	li	a0,0
 2ca:	00000097          	auipc	ra,0x0
 2ce:	4c2080e7          	jalr	1218(ra) # 78c <exit>

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
 306:	172080e7          	jalr	370(ra) # 474 <twhoami>
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
 352:	9d250513          	addi	a0,a0,-1582 # d20 <malloc+0x15c>
 356:	00000097          	auipc	ra,0x0
 35a:	7b6080e7          	jalr	1974(ra) # b0c <printf>
        exit(-1);
 35e:	557d                	li	a0,-1
 360:	00000097          	auipc	ra,0x0
 364:	42c080e7          	jalr	1068(ra) # 78c <exit>
    {
        // give up the cpu for other threads
        tyield();
 368:	00000097          	auipc	ra,0x0
 36c:	0f4080e7          	jalr	244(ra) # 45c <tyield>
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
 386:	0f2080e7          	jalr	242(ra) # 474 <twhoami>
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
 3ca:	096080e7          	jalr	150(ra) # 45c <tyield>
}
 3ce:	60e2                	ld	ra,24(sp)
 3d0:	6442                	ld	s0,16(sp)
 3d2:	64a2                	ld	s1,8(sp)
 3d4:	6105                	addi	sp,sp,32
 3d6:	8082                	ret
        printf("releasing lock we are not holding");
 3d8:	00001517          	auipc	a0,0x1
 3dc:	97050513          	addi	a0,a0,-1680 # d48 <malloc+0x184>
 3e0:	00000097          	auipc	ra,0x0
 3e4:	72c080e7          	jalr	1836(ra) # b0c <printf>
        exit(-1);
 3e8:	557d                	li	a0,-1
 3ea:	00000097          	auipc	ra,0x0
 3ee:	3a2080e7          	jalr	930(ra) # 78c <exit>

00000000000003f2 <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
 3f2:	1141                	addi	sp,sp,-16
 3f4:	e422                	sd	s0,8(sp)
 3f6:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 3f8:	00001717          	auipc	a4,0x1
 3fc:	c0873703          	ld	a4,-1016(a4) # 1000 <current_thread>
 400:	47c1                	li	a5,16
 402:	c319                	beqz	a4,408 <tsched+0x16>
    for (int i = 0; i < 16; i++) {
 404:	37fd                	addiw	a5,a5,-1
 406:	fff5                	bnez	a5,402 <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
 408:	6422                	ld	s0,8(sp)
 40a:	0141                	addi	sp,sp,16
 40c:	8082                	ret

000000000000040e <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 40e:	7179                	addi	sp,sp,-48
 410:	f406                	sd	ra,40(sp)
 412:	f022                	sd	s0,32(sp)
 414:	ec26                	sd	s1,24(sp)
 416:	e84a                	sd	s2,16(sp)
 418:	e44e                	sd	s3,8(sp)
 41a:	1800                	addi	s0,sp,48
 41c:	84aa                	mv	s1,a0
 41e:	89b2                	mv	s3,a2
 420:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 422:	09000513          	li	a0,144
 426:	00000097          	auipc	ra,0x0
 42a:	79e080e7          	jalr	1950(ra) # bc4 <malloc>
 42e:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 430:	478d                	li	a5,3
 432:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 434:	609c                	ld	a5,0(s1)
 436:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 43a:	609c                	ld	a5,0(s1)
 43c:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
 440:	70a2                	ld	ra,40(sp)
 442:	7402                	ld	s0,32(sp)
 444:	64e2                	ld	s1,24(sp)
 446:	6942                	ld	s2,16(sp)
 448:	69a2                	ld	s3,8(sp)
 44a:	6145                	addi	sp,sp,48
 44c:	8082                	ret

000000000000044e <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 44e:	1141                	addi	sp,sp,-16
 450:	e422                	sd	s0,8(sp)
 452:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
 454:	4501                	li	a0,0
 456:	6422                	ld	s0,8(sp)
 458:	0141                	addi	sp,sp,16
 45a:	8082                	ret

000000000000045c <tyield>:

void tyield()
{
 45c:	1141                	addi	sp,sp,-16
 45e:	e422                	sd	s0,8(sp)
 460:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 462:	00001797          	auipc	a5,0x1
 466:	b9e7b783          	ld	a5,-1122(a5) # 1000 <current_thread>
 46a:	470d                	li	a4,3
 46c:	dfb8                	sw	a4,120(a5)
    tsched();
}
 46e:	6422                	ld	s0,8(sp)
 470:	0141                	addi	sp,sp,16
 472:	8082                	ret

0000000000000474 <twhoami>:

uint8 twhoami()
{
 474:	1141                	addi	sp,sp,-16
 476:	e422                	sd	s0,8(sp)
 478:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
 47a:	4501                	li	a0,0
 47c:	6422                	ld	s0,8(sp)
 47e:	0141                	addi	sp,sp,16
 480:	8082                	ret

0000000000000482 <tswtch>:
 482:	00153023          	sd	ra,0(a0)
 486:	00253423          	sd	sp,8(a0)
 48a:	e900                	sd	s0,16(a0)
 48c:	ed04                	sd	s1,24(a0)
 48e:	03253023          	sd	s2,32(a0)
 492:	03353423          	sd	s3,40(a0)
 496:	03453823          	sd	s4,48(a0)
 49a:	03553c23          	sd	s5,56(a0)
 49e:	05653023          	sd	s6,64(a0)
 4a2:	05753423          	sd	s7,72(a0)
 4a6:	05853823          	sd	s8,80(a0)
 4aa:	05953c23          	sd	s9,88(a0)
 4ae:	07a53023          	sd	s10,96(a0)
 4b2:	07b53423          	sd	s11,104(a0)
 4b6:	0005b083          	ld	ra,0(a1)
 4ba:	0085b103          	ld	sp,8(a1)
 4be:	6980                	ld	s0,16(a1)
 4c0:	6d84                	ld	s1,24(a1)
 4c2:	0205b903          	ld	s2,32(a1)
 4c6:	0285b983          	ld	s3,40(a1)
 4ca:	0305ba03          	ld	s4,48(a1)
 4ce:	0385ba83          	ld	s5,56(a1)
 4d2:	0405bb03          	ld	s6,64(a1)
 4d6:	0485bb83          	ld	s7,72(a1)
 4da:	0505bc03          	ld	s8,80(a1)
 4de:	0585bc83          	ld	s9,88(a1)
 4e2:	0605bd03          	ld	s10,96(a1)
 4e6:	0685bd83          	ld	s11,104(a1)
 4ea:	8082                	ret

00000000000004ec <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 4ec:	1101                	addi	sp,sp,-32
 4ee:	ec06                	sd	ra,24(sp)
 4f0:	e822                	sd	s0,16(sp)
 4f2:	e426                	sd	s1,8(sp)
 4f4:	e04a                	sd	s2,0(sp)
 4f6:	1000                	addi	s0,sp,32
 4f8:	84aa                	mv	s1,a0
 4fa:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 4fc:	09000513          	li	a0,144
 500:	00000097          	auipc	ra,0x0
 504:	6c4080e7          	jalr	1732(ra) # bc4 <malloc>

    main_thread->tid = 0;
 508:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 50c:	85ca                	mv	a1,s2
 50e:	8526                	mv	a0,s1
 510:	00000097          	auipc	ra,0x0
 514:	d68080e7          	jalr	-664(ra) # 278 <main>
    exit(res);
 518:	00000097          	auipc	ra,0x0
 51c:	274080e7          	jalr	628(ra) # 78c <exit>

0000000000000520 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 520:	1141                	addi	sp,sp,-16
 522:	e422                	sd	s0,8(sp)
 524:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 526:	87aa                	mv	a5,a0
 528:	0585                	addi	a1,a1,1
 52a:	0785                	addi	a5,a5,1
 52c:	fff5c703          	lbu	a4,-1(a1)
 530:	fee78fa3          	sb	a4,-1(a5)
 534:	fb75                	bnez	a4,528 <strcpy+0x8>
        ;
    return os;
}
 536:	6422                	ld	s0,8(sp)
 538:	0141                	addi	sp,sp,16
 53a:	8082                	ret

000000000000053c <strcmp>:

int strcmp(const char *p, const char *q)
{
 53c:	1141                	addi	sp,sp,-16
 53e:	e422                	sd	s0,8(sp)
 540:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 542:	00054783          	lbu	a5,0(a0)
 546:	cb91                	beqz	a5,55a <strcmp+0x1e>
 548:	0005c703          	lbu	a4,0(a1)
 54c:	00f71763          	bne	a4,a5,55a <strcmp+0x1e>
        p++, q++;
 550:	0505                	addi	a0,a0,1
 552:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 554:	00054783          	lbu	a5,0(a0)
 558:	fbe5                	bnez	a5,548 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 55a:	0005c503          	lbu	a0,0(a1)
}
 55e:	40a7853b          	subw	a0,a5,a0
 562:	6422                	ld	s0,8(sp)
 564:	0141                	addi	sp,sp,16
 566:	8082                	ret

0000000000000568 <strlen>:

uint strlen(const char *s)
{
 568:	1141                	addi	sp,sp,-16
 56a:	e422                	sd	s0,8(sp)
 56c:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 56e:	00054783          	lbu	a5,0(a0)
 572:	cf91                	beqz	a5,58e <strlen+0x26>
 574:	0505                	addi	a0,a0,1
 576:	87aa                	mv	a5,a0
 578:	86be                	mv	a3,a5
 57a:	0785                	addi	a5,a5,1
 57c:	fff7c703          	lbu	a4,-1(a5)
 580:	ff65                	bnez	a4,578 <strlen+0x10>
 582:	40a6853b          	subw	a0,a3,a0
 586:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 588:	6422                	ld	s0,8(sp)
 58a:	0141                	addi	sp,sp,16
 58c:	8082                	ret
    for (n = 0; s[n]; n++)
 58e:	4501                	li	a0,0
 590:	bfe5                	j	588 <strlen+0x20>

0000000000000592 <memset>:

void *
memset(void *dst, int c, uint n)
{
 592:	1141                	addi	sp,sp,-16
 594:	e422                	sd	s0,8(sp)
 596:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 598:	ca19                	beqz	a2,5ae <memset+0x1c>
 59a:	87aa                	mv	a5,a0
 59c:	1602                	slli	a2,a2,0x20
 59e:	9201                	srli	a2,a2,0x20
 5a0:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 5a4:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 5a8:	0785                	addi	a5,a5,1
 5aa:	fee79de3          	bne	a5,a4,5a4 <memset+0x12>
    }
    return dst;
}
 5ae:	6422                	ld	s0,8(sp)
 5b0:	0141                	addi	sp,sp,16
 5b2:	8082                	ret

00000000000005b4 <strchr>:

char *
strchr(const char *s, char c)
{
 5b4:	1141                	addi	sp,sp,-16
 5b6:	e422                	sd	s0,8(sp)
 5b8:	0800                	addi	s0,sp,16
    for (; *s; s++)
 5ba:	00054783          	lbu	a5,0(a0)
 5be:	cb99                	beqz	a5,5d4 <strchr+0x20>
        if (*s == c)
 5c0:	00f58763          	beq	a1,a5,5ce <strchr+0x1a>
    for (; *s; s++)
 5c4:	0505                	addi	a0,a0,1
 5c6:	00054783          	lbu	a5,0(a0)
 5ca:	fbfd                	bnez	a5,5c0 <strchr+0xc>
            return (char *)s;
    return 0;
 5cc:	4501                	li	a0,0
}
 5ce:	6422                	ld	s0,8(sp)
 5d0:	0141                	addi	sp,sp,16
 5d2:	8082                	ret
    return 0;
 5d4:	4501                	li	a0,0
 5d6:	bfe5                	j	5ce <strchr+0x1a>

00000000000005d8 <gets>:

char *
gets(char *buf, int max)
{
 5d8:	711d                	addi	sp,sp,-96
 5da:	ec86                	sd	ra,88(sp)
 5dc:	e8a2                	sd	s0,80(sp)
 5de:	e4a6                	sd	s1,72(sp)
 5e0:	e0ca                	sd	s2,64(sp)
 5e2:	fc4e                	sd	s3,56(sp)
 5e4:	f852                	sd	s4,48(sp)
 5e6:	f456                	sd	s5,40(sp)
 5e8:	f05a                	sd	s6,32(sp)
 5ea:	ec5e                	sd	s7,24(sp)
 5ec:	1080                	addi	s0,sp,96
 5ee:	8baa                	mv	s7,a0
 5f0:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 5f2:	892a                	mv	s2,a0
 5f4:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 5f6:	4aa9                	li	s5,10
 5f8:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 5fa:	89a6                	mv	s3,s1
 5fc:	2485                	addiw	s1,s1,1
 5fe:	0344d863          	bge	s1,s4,62e <gets+0x56>
        cc = read(0, &c, 1);
 602:	4605                	li	a2,1
 604:	faf40593          	addi	a1,s0,-81
 608:	4501                	li	a0,0
 60a:	00000097          	auipc	ra,0x0
 60e:	19a080e7          	jalr	410(ra) # 7a4 <read>
        if (cc < 1)
 612:	00a05e63          	blez	a0,62e <gets+0x56>
        buf[i++] = c;
 616:	faf44783          	lbu	a5,-81(s0)
 61a:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 61e:	01578763          	beq	a5,s5,62c <gets+0x54>
 622:	0905                	addi	s2,s2,1
 624:	fd679be3          	bne	a5,s6,5fa <gets+0x22>
    for (i = 0; i + 1 < max;)
 628:	89a6                	mv	s3,s1
 62a:	a011                	j	62e <gets+0x56>
 62c:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 62e:	99de                	add	s3,s3,s7
 630:	00098023          	sb	zero,0(s3)
    return buf;
}
 634:	855e                	mv	a0,s7
 636:	60e6                	ld	ra,88(sp)
 638:	6446                	ld	s0,80(sp)
 63a:	64a6                	ld	s1,72(sp)
 63c:	6906                	ld	s2,64(sp)
 63e:	79e2                	ld	s3,56(sp)
 640:	7a42                	ld	s4,48(sp)
 642:	7aa2                	ld	s5,40(sp)
 644:	7b02                	ld	s6,32(sp)
 646:	6be2                	ld	s7,24(sp)
 648:	6125                	addi	sp,sp,96
 64a:	8082                	ret

000000000000064c <stat>:

int stat(const char *n, struct stat *st)
{
 64c:	1101                	addi	sp,sp,-32
 64e:	ec06                	sd	ra,24(sp)
 650:	e822                	sd	s0,16(sp)
 652:	e426                	sd	s1,8(sp)
 654:	e04a                	sd	s2,0(sp)
 656:	1000                	addi	s0,sp,32
 658:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 65a:	4581                	li	a1,0
 65c:	00000097          	auipc	ra,0x0
 660:	170080e7          	jalr	368(ra) # 7cc <open>
    if (fd < 0)
 664:	02054563          	bltz	a0,68e <stat+0x42>
 668:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 66a:	85ca                	mv	a1,s2
 66c:	00000097          	auipc	ra,0x0
 670:	178080e7          	jalr	376(ra) # 7e4 <fstat>
 674:	892a                	mv	s2,a0
    close(fd);
 676:	8526                	mv	a0,s1
 678:	00000097          	auipc	ra,0x0
 67c:	13c080e7          	jalr	316(ra) # 7b4 <close>
    return r;
}
 680:	854a                	mv	a0,s2
 682:	60e2                	ld	ra,24(sp)
 684:	6442                	ld	s0,16(sp)
 686:	64a2                	ld	s1,8(sp)
 688:	6902                	ld	s2,0(sp)
 68a:	6105                	addi	sp,sp,32
 68c:	8082                	ret
        return -1;
 68e:	597d                	li	s2,-1
 690:	bfc5                	j	680 <stat+0x34>

0000000000000692 <atoi>:

int atoi(const char *s)
{
 692:	1141                	addi	sp,sp,-16
 694:	e422                	sd	s0,8(sp)
 696:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 698:	00054683          	lbu	a3,0(a0)
 69c:	fd06879b          	addiw	a5,a3,-48
 6a0:	0ff7f793          	zext.b	a5,a5
 6a4:	4625                	li	a2,9
 6a6:	02f66863          	bltu	a2,a5,6d6 <atoi+0x44>
 6aa:	872a                	mv	a4,a0
    n = 0;
 6ac:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 6ae:	0705                	addi	a4,a4,1
 6b0:	0025179b          	slliw	a5,a0,0x2
 6b4:	9fa9                	addw	a5,a5,a0
 6b6:	0017979b          	slliw	a5,a5,0x1
 6ba:	9fb5                	addw	a5,a5,a3
 6bc:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 6c0:	00074683          	lbu	a3,0(a4)
 6c4:	fd06879b          	addiw	a5,a3,-48
 6c8:	0ff7f793          	zext.b	a5,a5
 6cc:	fef671e3          	bgeu	a2,a5,6ae <atoi+0x1c>
    return n;
}
 6d0:	6422                	ld	s0,8(sp)
 6d2:	0141                	addi	sp,sp,16
 6d4:	8082                	ret
    n = 0;
 6d6:	4501                	li	a0,0
 6d8:	bfe5                	j	6d0 <atoi+0x3e>

00000000000006da <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 6da:	1141                	addi	sp,sp,-16
 6dc:	e422                	sd	s0,8(sp)
 6de:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 6e0:	02b57463          	bgeu	a0,a1,708 <memmove+0x2e>
    {
        while (n-- > 0)
 6e4:	00c05f63          	blez	a2,702 <memmove+0x28>
 6e8:	1602                	slli	a2,a2,0x20
 6ea:	9201                	srli	a2,a2,0x20
 6ec:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 6f0:	872a                	mv	a4,a0
            *dst++ = *src++;
 6f2:	0585                	addi	a1,a1,1
 6f4:	0705                	addi	a4,a4,1
 6f6:	fff5c683          	lbu	a3,-1(a1)
 6fa:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 6fe:	fee79ae3          	bne	a5,a4,6f2 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 702:	6422                	ld	s0,8(sp)
 704:	0141                	addi	sp,sp,16
 706:	8082                	ret
        dst += n;
 708:	00c50733          	add	a4,a0,a2
        src += n;
 70c:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 70e:	fec05ae3          	blez	a2,702 <memmove+0x28>
 712:	fff6079b          	addiw	a5,a2,-1
 716:	1782                	slli	a5,a5,0x20
 718:	9381                	srli	a5,a5,0x20
 71a:	fff7c793          	not	a5,a5
 71e:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 720:	15fd                	addi	a1,a1,-1
 722:	177d                	addi	a4,a4,-1
 724:	0005c683          	lbu	a3,0(a1)
 728:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 72c:	fee79ae3          	bne	a5,a4,720 <memmove+0x46>
 730:	bfc9                	j	702 <memmove+0x28>

0000000000000732 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 732:	1141                	addi	sp,sp,-16
 734:	e422                	sd	s0,8(sp)
 736:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 738:	ca05                	beqz	a2,768 <memcmp+0x36>
 73a:	fff6069b          	addiw	a3,a2,-1
 73e:	1682                	slli	a3,a3,0x20
 740:	9281                	srli	a3,a3,0x20
 742:	0685                	addi	a3,a3,1
 744:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 746:	00054783          	lbu	a5,0(a0)
 74a:	0005c703          	lbu	a4,0(a1)
 74e:	00e79863          	bne	a5,a4,75e <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 752:	0505                	addi	a0,a0,1
        p2++;
 754:	0585                	addi	a1,a1,1
    while (n-- > 0)
 756:	fed518e3          	bne	a0,a3,746 <memcmp+0x14>
    }
    return 0;
 75a:	4501                	li	a0,0
 75c:	a019                	j	762 <memcmp+0x30>
            return *p1 - *p2;
 75e:	40e7853b          	subw	a0,a5,a4
}
 762:	6422                	ld	s0,8(sp)
 764:	0141                	addi	sp,sp,16
 766:	8082                	ret
    return 0;
 768:	4501                	li	a0,0
 76a:	bfe5                	j	762 <memcmp+0x30>

000000000000076c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 76c:	1141                	addi	sp,sp,-16
 76e:	e406                	sd	ra,8(sp)
 770:	e022                	sd	s0,0(sp)
 772:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 774:	00000097          	auipc	ra,0x0
 778:	f66080e7          	jalr	-154(ra) # 6da <memmove>
}
 77c:	60a2                	ld	ra,8(sp)
 77e:	6402                	ld	s0,0(sp)
 780:	0141                	addi	sp,sp,16
 782:	8082                	ret

0000000000000784 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 784:	4885                	li	a7,1
 ecall
 786:	00000073          	ecall
 ret
 78a:	8082                	ret

000000000000078c <exit>:
.global exit
exit:
 li a7, SYS_exit
 78c:	4889                	li	a7,2
 ecall
 78e:	00000073          	ecall
 ret
 792:	8082                	ret

0000000000000794 <wait>:
.global wait
wait:
 li a7, SYS_wait
 794:	488d                	li	a7,3
 ecall
 796:	00000073          	ecall
 ret
 79a:	8082                	ret

000000000000079c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 79c:	4891                	li	a7,4
 ecall
 79e:	00000073          	ecall
 ret
 7a2:	8082                	ret

00000000000007a4 <read>:
.global read
read:
 li a7, SYS_read
 7a4:	4895                	li	a7,5
 ecall
 7a6:	00000073          	ecall
 ret
 7aa:	8082                	ret

00000000000007ac <write>:
.global write
write:
 li a7, SYS_write
 7ac:	48c1                	li	a7,16
 ecall
 7ae:	00000073          	ecall
 ret
 7b2:	8082                	ret

00000000000007b4 <close>:
.global close
close:
 li a7, SYS_close
 7b4:	48d5                	li	a7,21
 ecall
 7b6:	00000073          	ecall
 ret
 7ba:	8082                	ret

00000000000007bc <kill>:
.global kill
kill:
 li a7, SYS_kill
 7bc:	4899                	li	a7,6
 ecall
 7be:	00000073          	ecall
 ret
 7c2:	8082                	ret

00000000000007c4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 7c4:	489d                	li	a7,7
 ecall
 7c6:	00000073          	ecall
 ret
 7ca:	8082                	ret

00000000000007cc <open>:
.global open
open:
 li a7, SYS_open
 7cc:	48bd                	li	a7,15
 ecall
 7ce:	00000073          	ecall
 ret
 7d2:	8082                	ret

00000000000007d4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7d4:	48c5                	li	a7,17
 ecall
 7d6:	00000073          	ecall
 ret
 7da:	8082                	ret

00000000000007dc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7dc:	48c9                	li	a7,18
 ecall
 7de:	00000073          	ecall
 ret
 7e2:	8082                	ret

00000000000007e4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7e4:	48a1                	li	a7,8
 ecall
 7e6:	00000073          	ecall
 ret
 7ea:	8082                	ret

00000000000007ec <link>:
.global link
link:
 li a7, SYS_link
 7ec:	48cd                	li	a7,19
 ecall
 7ee:	00000073          	ecall
 ret
 7f2:	8082                	ret

00000000000007f4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7f4:	48d1                	li	a7,20
 ecall
 7f6:	00000073          	ecall
 ret
 7fa:	8082                	ret

00000000000007fc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7fc:	48a5                	li	a7,9
 ecall
 7fe:	00000073          	ecall
 ret
 802:	8082                	ret

0000000000000804 <dup>:
.global dup
dup:
 li a7, SYS_dup
 804:	48a9                	li	a7,10
 ecall
 806:	00000073          	ecall
 ret
 80a:	8082                	ret

000000000000080c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 80c:	48ad                	li	a7,11
 ecall
 80e:	00000073          	ecall
 ret
 812:	8082                	ret

0000000000000814 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 814:	48b1                	li	a7,12
 ecall
 816:	00000073          	ecall
 ret
 81a:	8082                	ret

000000000000081c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 81c:	48b5                	li	a7,13
 ecall
 81e:	00000073          	ecall
 ret
 822:	8082                	ret

0000000000000824 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 824:	48b9                	li	a7,14
 ecall
 826:	00000073          	ecall
 ret
 82a:	8082                	ret

000000000000082c <ps>:
.global ps
ps:
 li a7, SYS_ps
 82c:	48d9                	li	a7,22
 ecall
 82e:	00000073          	ecall
 ret
 832:	8082                	ret

0000000000000834 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 834:	48dd                	li	a7,23
 ecall
 836:	00000073          	ecall
 ret
 83a:	8082                	ret

000000000000083c <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 83c:	48e1                	li	a7,24
 ecall
 83e:	00000073          	ecall
 ret
 842:	8082                	ret

0000000000000844 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 844:	1101                	addi	sp,sp,-32
 846:	ec06                	sd	ra,24(sp)
 848:	e822                	sd	s0,16(sp)
 84a:	1000                	addi	s0,sp,32
 84c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 850:	4605                	li	a2,1
 852:	fef40593          	addi	a1,s0,-17
 856:	00000097          	auipc	ra,0x0
 85a:	f56080e7          	jalr	-170(ra) # 7ac <write>
}
 85e:	60e2                	ld	ra,24(sp)
 860:	6442                	ld	s0,16(sp)
 862:	6105                	addi	sp,sp,32
 864:	8082                	ret

0000000000000866 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 866:	7139                	addi	sp,sp,-64
 868:	fc06                	sd	ra,56(sp)
 86a:	f822                	sd	s0,48(sp)
 86c:	f426                	sd	s1,40(sp)
 86e:	f04a                	sd	s2,32(sp)
 870:	ec4e                	sd	s3,24(sp)
 872:	0080                	addi	s0,sp,64
 874:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 876:	c299                	beqz	a3,87c <printint+0x16>
 878:	0805c963          	bltz	a1,90a <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 87c:	2581                	sext.w	a1,a1
  neg = 0;
 87e:	4881                	li	a7,0
 880:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 884:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 886:	2601                	sext.w	a2,a2
 888:	00000517          	auipc	a0,0x0
 88c:	54850513          	addi	a0,a0,1352 # dd0 <digits>
 890:	883a                	mv	a6,a4
 892:	2705                	addiw	a4,a4,1
 894:	02c5f7bb          	remuw	a5,a1,a2
 898:	1782                	slli	a5,a5,0x20
 89a:	9381                	srli	a5,a5,0x20
 89c:	97aa                	add	a5,a5,a0
 89e:	0007c783          	lbu	a5,0(a5)
 8a2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 8a6:	0005879b          	sext.w	a5,a1
 8aa:	02c5d5bb          	divuw	a1,a1,a2
 8ae:	0685                	addi	a3,a3,1
 8b0:	fec7f0e3          	bgeu	a5,a2,890 <printint+0x2a>
  if(neg)
 8b4:	00088c63          	beqz	a7,8cc <printint+0x66>
    buf[i++] = '-';
 8b8:	fd070793          	addi	a5,a4,-48
 8bc:	00878733          	add	a4,a5,s0
 8c0:	02d00793          	li	a5,45
 8c4:	fef70823          	sb	a5,-16(a4)
 8c8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 8cc:	02e05863          	blez	a4,8fc <printint+0x96>
 8d0:	fc040793          	addi	a5,s0,-64
 8d4:	00e78933          	add	s2,a5,a4
 8d8:	fff78993          	addi	s3,a5,-1
 8dc:	99ba                	add	s3,s3,a4
 8de:	377d                	addiw	a4,a4,-1
 8e0:	1702                	slli	a4,a4,0x20
 8e2:	9301                	srli	a4,a4,0x20
 8e4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8e8:	fff94583          	lbu	a1,-1(s2)
 8ec:	8526                	mv	a0,s1
 8ee:	00000097          	auipc	ra,0x0
 8f2:	f56080e7          	jalr	-170(ra) # 844 <putc>
  while(--i >= 0)
 8f6:	197d                	addi	s2,s2,-1
 8f8:	ff3918e3          	bne	s2,s3,8e8 <printint+0x82>
}
 8fc:	70e2                	ld	ra,56(sp)
 8fe:	7442                	ld	s0,48(sp)
 900:	74a2                	ld	s1,40(sp)
 902:	7902                	ld	s2,32(sp)
 904:	69e2                	ld	s3,24(sp)
 906:	6121                	addi	sp,sp,64
 908:	8082                	ret
    x = -xx;
 90a:	40b005bb          	negw	a1,a1
    neg = 1;
 90e:	4885                	li	a7,1
    x = -xx;
 910:	bf85                	j	880 <printint+0x1a>

0000000000000912 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 912:	715d                	addi	sp,sp,-80
 914:	e486                	sd	ra,72(sp)
 916:	e0a2                	sd	s0,64(sp)
 918:	fc26                	sd	s1,56(sp)
 91a:	f84a                	sd	s2,48(sp)
 91c:	f44e                	sd	s3,40(sp)
 91e:	f052                	sd	s4,32(sp)
 920:	ec56                	sd	s5,24(sp)
 922:	e85a                	sd	s6,16(sp)
 924:	e45e                	sd	s7,8(sp)
 926:	e062                	sd	s8,0(sp)
 928:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 92a:	0005c903          	lbu	s2,0(a1)
 92e:	18090c63          	beqz	s2,ac6 <vprintf+0x1b4>
 932:	8aaa                	mv	s5,a0
 934:	8bb2                	mv	s7,a2
 936:	00158493          	addi	s1,a1,1
  state = 0;
 93a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 93c:	02500a13          	li	s4,37
 940:	4b55                	li	s6,21
 942:	a839                	j	960 <vprintf+0x4e>
        putc(fd, c);
 944:	85ca                	mv	a1,s2
 946:	8556                	mv	a0,s5
 948:	00000097          	auipc	ra,0x0
 94c:	efc080e7          	jalr	-260(ra) # 844 <putc>
 950:	a019                	j	956 <vprintf+0x44>
    } else if(state == '%'){
 952:	01498d63          	beq	s3,s4,96c <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 956:	0485                	addi	s1,s1,1
 958:	fff4c903          	lbu	s2,-1(s1)
 95c:	16090563          	beqz	s2,ac6 <vprintf+0x1b4>
    if(state == 0){
 960:	fe0999e3          	bnez	s3,952 <vprintf+0x40>
      if(c == '%'){
 964:	ff4910e3          	bne	s2,s4,944 <vprintf+0x32>
        state = '%';
 968:	89d2                	mv	s3,s4
 96a:	b7f5                	j	956 <vprintf+0x44>
      if(c == 'd'){
 96c:	13490263          	beq	s2,s4,a90 <vprintf+0x17e>
 970:	f9d9079b          	addiw	a5,s2,-99
 974:	0ff7f793          	zext.b	a5,a5
 978:	12fb6563          	bltu	s6,a5,aa2 <vprintf+0x190>
 97c:	f9d9079b          	addiw	a5,s2,-99
 980:	0ff7f713          	zext.b	a4,a5
 984:	10eb6f63          	bltu	s6,a4,aa2 <vprintf+0x190>
 988:	00271793          	slli	a5,a4,0x2
 98c:	00000717          	auipc	a4,0x0
 990:	3ec70713          	addi	a4,a4,1004 # d78 <malloc+0x1b4>
 994:	97ba                	add	a5,a5,a4
 996:	439c                	lw	a5,0(a5)
 998:	97ba                	add	a5,a5,a4
 99a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 99c:	008b8913          	addi	s2,s7,8
 9a0:	4685                	li	a3,1
 9a2:	4629                	li	a2,10
 9a4:	000ba583          	lw	a1,0(s7)
 9a8:	8556                	mv	a0,s5
 9aa:	00000097          	auipc	ra,0x0
 9ae:	ebc080e7          	jalr	-324(ra) # 866 <printint>
 9b2:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9b4:	4981                	li	s3,0
 9b6:	b745                	j	956 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9b8:	008b8913          	addi	s2,s7,8
 9bc:	4681                	li	a3,0
 9be:	4629                	li	a2,10
 9c0:	000ba583          	lw	a1,0(s7)
 9c4:	8556                	mv	a0,s5
 9c6:	00000097          	auipc	ra,0x0
 9ca:	ea0080e7          	jalr	-352(ra) # 866 <printint>
 9ce:	8bca                	mv	s7,s2
      state = 0;
 9d0:	4981                	li	s3,0
 9d2:	b751                	j	956 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 9d4:	008b8913          	addi	s2,s7,8
 9d8:	4681                	li	a3,0
 9da:	4641                	li	a2,16
 9dc:	000ba583          	lw	a1,0(s7)
 9e0:	8556                	mv	a0,s5
 9e2:	00000097          	auipc	ra,0x0
 9e6:	e84080e7          	jalr	-380(ra) # 866 <printint>
 9ea:	8bca                	mv	s7,s2
      state = 0;
 9ec:	4981                	li	s3,0
 9ee:	b7a5                	j	956 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 9f0:	008b8c13          	addi	s8,s7,8
 9f4:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9f8:	03000593          	li	a1,48
 9fc:	8556                	mv	a0,s5
 9fe:	00000097          	auipc	ra,0x0
 a02:	e46080e7          	jalr	-442(ra) # 844 <putc>
  putc(fd, 'x');
 a06:	07800593          	li	a1,120
 a0a:	8556                	mv	a0,s5
 a0c:	00000097          	auipc	ra,0x0
 a10:	e38080e7          	jalr	-456(ra) # 844 <putc>
 a14:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a16:	00000b97          	auipc	s7,0x0
 a1a:	3bab8b93          	addi	s7,s7,954 # dd0 <digits>
 a1e:	03c9d793          	srli	a5,s3,0x3c
 a22:	97de                	add	a5,a5,s7
 a24:	0007c583          	lbu	a1,0(a5)
 a28:	8556                	mv	a0,s5
 a2a:	00000097          	auipc	ra,0x0
 a2e:	e1a080e7          	jalr	-486(ra) # 844 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a32:	0992                	slli	s3,s3,0x4
 a34:	397d                	addiw	s2,s2,-1
 a36:	fe0914e3          	bnez	s2,a1e <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 a3a:	8be2                	mv	s7,s8
      state = 0;
 a3c:	4981                	li	s3,0
 a3e:	bf21                	j	956 <vprintf+0x44>
        s = va_arg(ap, char*);
 a40:	008b8993          	addi	s3,s7,8
 a44:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a48:	02090163          	beqz	s2,a6a <vprintf+0x158>
        while(*s != 0){
 a4c:	00094583          	lbu	a1,0(s2)
 a50:	c9a5                	beqz	a1,ac0 <vprintf+0x1ae>
          putc(fd, *s);
 a52:	8556                	mv	a0,s5
 a54:	00000097          	auipc	ra,0x0
 a58:	df0080e7          	jalr	-528(ra) # 844 <putc>
          s++;
 a5c:	0905                	addi	s2,s2,1
        while(*s != 0){
 a5e:	00094583          	lbu	a1,0(s2)
 a62:	f9e5                	bnez	a1,a52 <vprintf+0x140>
        s = va_arg(ap, char*);
 a64:	8bce                	mv	s7,s3
      state = 0;
 a66:	4981                	li	s3,0
 a68:	b5fd                	j	956 <vprintf+0x44>
          s = "(null)";
 a6a:	00000917          	auipc	s2,0x0
 a6e:	30690913          	addi	s2,s2,774 # d70 <malloc+0x1ac>
        while(*s != 0){
 a72:	02800593          	li	a1,40
 a76:	bff1                	j	a52 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a78:	008b8913          	addi	s2,s7,8
 a7c:	000bc583          	lbu	a1,0(s7)
 a80:	8556                	mv	a0,s5
 a82:	00000097          	auipc	ra,0x0
 a86:	dc2080e7          	jalr	-574(ra) # 844 <putc>
 a8a:	8bca                	mv	s7,s2
      state = 0;
 a8c:	4981                	li	s3,0
 a8e:	b5e1                	j	956 <vprintf+0x44>
        putc(fd, c);
 a90:	02500593          	li	a1,37
 a94:	8556                	mv	a0,s5
 a96:	00000097          	auipc	ra,0x0
 a9a:	dae080e7          	jalr	-594(ra) # 844 <putc>
      state = 0;
 a9e:	4981                	li	s3,0
 aa0:	bd5d                	j	956 <vprintf+0x44>
        putc(fd, '%');
 aa2:	02500593          	li	a1,37
 aa6:	8556                	mv	a0,s5
 aa8:	00000097          	auipc	ra,0x0
 aac:	d9c080e7          	jalr	-612(ra) # 844 <putc>
        putc(fd, c);
 ab0:	85ca                	mv	a1,s2
 ab2:	8556                	mv	a0,s5
 ab4:	00000097          	auipc	ra,0x0
 ab8:	d90080e7          	jalr	-624(ra) # 844 <putc>
      state = 0;
 abc:	4981                	li	s3,0
 abe:	bd61                	j	956 <vprintf+0x44>
        s = va_arg(ap, char*);
 ac0:	8bce                	mv	s7,s3
      state = 0;
 ac2:	4981                	li	s3,0
 ac4:	bd49                	j	956 <vprintf+0x44>
    }
  }
}
 ac6:	60a6                	ld	ra,72(sp)
 ac8:	6406                	ld	s0,64(sp)
 aca:	74e2                	ld	s1,56(sp)
 acc:	7942                	ld	s2,48(sp)
 ace:	79a2                	ld	s3,40(sp)
 ad0:	7a02                	ld	s4,32(sp)
 ad2:	6ae2                	ld	s5,24(sp)
 ad4:	6b42                	ld	s6,16(sp)
 ad6:	6ba2                	ld	s7,8(sp)
 ad8:	6c02                	ld	s8,0(sp)
 ada:	6161                	addi	sp,sp,80
 adc:	8082                	ret

0000000000000ade <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ade:	715d                	addi	sp,sp,-80
 ae0:	ec06                	sd	ra,24(sp)
 ae2:	e822                	sd	s0,16(sp)
 ae4:	1000                	addi	s0,sp,32
 ae6:	e010                	sd	a2,0(s0)
 ae8:	e414                	sd	a3,8(s0)
 aea:	e818                	sd	a4,16(s0)
 aec:	ec1c                	sd	a5,24(s0)
 aee:	03043023          	sd	a6,32(s0)
 af2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 af6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 afa:	8622                	mv	a2,s0
 afc:	00000097          	auipc	ra,0x0
 b00:	e16080e7          	jalr	-490(ra) # 912 <vprintf>
}
 b04:	60e2                	ld	ra,24(sp)
 b06:	6442                	ld	s0,16(sp)
 b08:	6161                	addi	sp,sp,80
 b0a:	8082                	ret

0000000000000b0c <printf>:

void
printf(const char *fmt, ...)
{
 b0c:	711d                	addi	sp,sp,-96
 b0e:	ec06                	sd	ra,24(sp)
 b10:	e822                	sd	s0,16(sp)
 b12:	1000                	addi	s0,sp,32
 b14:	e40c                	sd	a1,8(s0)
 b16:	e810                	sd	a2,16(s0)
 b18:	ec14                	sd	a3,24(s0)
 b1a:	f018                	sd	a4,32(s0)
 b1c:	f41c                	sd	a5,40(s0)
 b1e:	03043823          	sd	a6,48(s0)
 b22:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b26:	00840613          	addi	a2,s0,8
 b2a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b2e:	85aa                	mv	a1,a0
 b30:	4505                	li	a0,1
 b32:	00000097          	auipc	ra,0x0
 b36:	de0080e7          	jalr	-544(ra) # 912 <vprintf>
}
 b3a:	60e2                	ld	ra,24(sp)
 b3c:	6442                	ld	s0,16(sp)
 b3e:	6125                	addi	sp,sp,96
 b40:	8082                	ret

0000000000000b42 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 b42:	1141                	addi	sp,sp,-16
 b44:	e422                	sd	s0,8(sp)
 b46:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 b48:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b4c:	00000797          	auipc	a5,0x0
 b50:	4bc7b783          	ld	a5,1212(a5) # 1008 <freep>
 b54:	a02d                	j	b7e <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 b56:	4618                	lw	a4,8(a2)
 b58:	9f2d                	addw	a4,a4,a1
 b5a:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 b5e:	6398                	ld	a4,0(a5)
 b60:	6310                	ld	a2,0(a4)
 b62:	a83d                	j	ba0 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 b64:	ff852703          	lw	a4,-8(a0)
 b68:	9f31                	addw	a4,a4,a2
 b6a:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 b6c:	ff053683          	ld	a3,-16(a0)
 b70:	a091                	j	bb4 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b72:	6398                	ld	a4,0(a5)
 b74:	00e7e463          	bltu	a5,a4,b7c <free+0x3a>
 b78:	00e6ea63          	bltu	a3,a4,b8c <free+0x4a>
{
 b7c:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b7e:	fed7fae3          	bgeu	a5,a3,b72 <free+0x30>
 b82:	6398                	ld	a4,0(a5)
 b84:	00e6e463          	bltu	a3,a4,b8c <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b88:	fee7eae3          	bltu	a5,a4,b7c <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 b8c:	ff852583          	lw	a1,-8(a0)
 b90:	6390                	ld	a2,0(a5)
 b92:	02059813          	slli	a6,a1,0x20
 b96:	01c85713          	srli	a4,a6,0x1c
 b9a:	9736                	add	a4,a4,a3
 b9c:	fae60de3          	beq	a2,a4,b56 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 ba0:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 ba4:	4790                	lw	a2,8(a5)
 ba6:	02061593          	slli	a1,a2,0x20
 baa:	01c5d713          	srli	a4,a1,0x1c
 bae:	973e                	add	a4,a4,a5
 bb0:	fae68ae3          	beq	a3,a4,b64 <free+0x22>
        p->s.ptr = bp->s.ptr;
 bb4:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 bb6:	00000717          	auipc	a4,0x0
 bba:	44f73923          	sd	a5,1106(a4) # 1008 <freep>
}
 bbe:	6422                	ld	s0,8(sp)
 bc0:	0141                	addi	sp,sp,16
 bc2:	8082                	ret

0000000000000bc4 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 bc4:	7139                	addi	sp,sp,-64
 bc6:	fc06                	sd	ra,56(sp)
 bc8:	f822                	sd	s0,48(sp)
 bca:	f426                	sd	s1,40(sp)
 bcc:	f04a                	sd	s2,32(sp)
 bce:	ec4e                	sd	s3,24(sp)
 bd0:	e852                	sd	s4,16(sp)
 bd2:	e456                	sd	s5,8(sp)
 bd4:	e05a                	sd	s6,0(sp)
 bd6:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 bd8:	02051493          	slli	s1,a0,0x20
 bdc:	9081                	srli	s1,s1,0x20
 bde:	04bd                	addi	s1,s1,15
 be0:	8091                	srli	s1,s1,0x4
 be2:	0014899b          	addiw	s3,s1,1
 be6:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 be8:	00000517          	auipc	a0,0x0
 bec:	42053503          	ld	a0,1056(a0) # 1008 <freep>
 bf0:	c515                	beqz	a0,c1c <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 bf2:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 bf4:	4798                	lw	a4,8(a5)
 bf6:	02977f63          	bgeu	a4,s1,c34 <malloc+0x70>
    if (nu < 4096)
 bfa:	8a4e                	mv	s4,s3
 bfc:	0009871b          	sext.w	a4,s3
 c00:	6685                	lui	a3,0x1
 c02:	00d77363          	bgeu	a4,a3,c08 <malloc+0x44>
 c06:	6a05                	lui	s4,0x1
 c08:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 c0c:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 c10:	00000917          	auipc	s2,0x0
 c14:	3f890913          	addi	s2,s2,1016 # 1008 <freep>
    if (p == (char *)-1)
 c18:	5afd                	li	s5,-1
 c1a:	a895                	j	c8e <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 c1c:	00000797          	auipc	a5,0x0
 c20:	40478793          	addi	a5,a5,1028 # 1020 <base>
 c24:	00000717          	auipc	a4,0x0
 c28:	3ef73223          	sd	a5,996(a4) # 1008 <freep>
 c2c:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 c2e:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 c32:	b7e1                	j	bfa <malloc+0x36>
            if (p->s.size == nunits)
 c34:	02e48c63          	beq	s1,a4,c6c <malloc+0xa8>
                p->s.size -= nunits;
 c38:	4137073b          	subw	a4,a4,s3
 c3c:	c798                	sw	a4,8(a5)
                p += p->s.size;
 c3e:	02071693          	slli	a3,a4,0x20
 c42:	01c6d713          	srli	a4,a3,0x1c
 c46:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 c48:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 c4c:	00000717          	auipc	a4,0x0
 c50:	3aa73e23          	sd	a0,956(a4) # 1008 <freep>
            return (void *)(p + 1);
 c54:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 c58:	70e2                	ld	ra,56(sp)
 c5a:	7442                	ld	s0,48(sp)
 c5c:	74a2                	ld	s1,40(sp)
 c5e:	7902                	ld	s2,32(sp)
 c60:	69e2                	ld	s3,24(sp)
 c62:	6a42                	ld	s4,16(sp)
 c64:	6aa2                	ld	s5,8(sp)
 c66:	6b02                	ld	s6,0(sp)
 c68:	6121                	addi	sp,sp,64
 c6a:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 c6c:	6398                	ld	a4,0(a5)
 c6e:	e118                	sd	a4,0(a0)
 c70:	bff1                	j	c4c <malloc+0x88>
    hp->s.size = nu;
 c72:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c76:	0541                	addi	a0,a0,16
 c78:	00000097          	auipc	ra,0x0
 c7c:	eca080e7          	jalr	-310(ra) # b42 <free>
    return freep;
 c80:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 c84:	d971                	beqz	a0,c58 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c86:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 c88:	4798                	lw	a4,8(a5)
 c8a:	fa9775e3          	bgeu	a4,s1,c34 <malloc+0x70>
        if (p == freep)
 c8e:	00093703          	ld	a4,0(s2)
 c92:	853e                	mv	a0,a5
 c94:	fef719e3          	bne	a4,a5,c86 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 c98:	8552                	mv	a0,s4
 c9a:	00000097          	auipc	ra,0x0
 c9e:	b7a080e7          	jalr	-1158(ra) # 814 <sbrk>
    if (p == (char *)-1)
 ca2:	fd5518e3          	bne	a0,s5,c72 <malloc+0xae>
                return 0;
 ca6:	4501                	li	a0,0
 ca8:	bf45                	j	c58 <malloc+0x94>
