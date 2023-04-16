
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
  14:	75a080e7          	jalr	1882(ra) # 76a <strlen>
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
  40:	72e080e7          	jalr	1838(ra) # 76a <strlen>
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
  62:	70c080e7          	jalr	1804(ra) # 76a <strlen>
  66:	00002997          	auipc	s3,0x2
  6a:	fba98993          	addi	s3,s3,-70 # 2020 <buf.0>
  6e:	0005061b          	sext.w	a2,a0
  72:	85a6                	mv	a1,s1
  74:	854e                	mv	a0,s3
  76:	00001097          	auipc	ra,0x1
  7a:	866080e7          	jalr	-1946(ra) # 8dc <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  7e:	8526                	mv	a0,s1
  80:	00000097          	auipc	ra,0x0
  84:	6ea080e7          	jalr	1770(ra) # 76a <strlen>
  88:	0005091b          	sext.w	s2,a0
  8c:	8526                	mv	a0,s1
  8e:	00000097          	auipc	ra,0x0
  92:	6dc080e7          	jalr	1756(ra) # 76a <strlen>
  96:	1902                	slli	s2,s2,0x20
  98:	02095913          	srli	s2,s2,0x20
  9c:	4639                	li	a2,14
  9e:	9e09                	subw	a2,a2,a0
  a0:	02000593          	li	a1,32
  a4:	01298533          	add	a0,s3,s2
  a8:	00000097          	auipc	ra,0x0
  ac:	6ec080e7          	jalr	1772(ra) # 794 <memset>
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
  de:	8f4080e7          	jalr	-1804(ra) # 9ce <open>
  e2:	06054f63          	bltz	a0,160 <ls+0xac>
  e6:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  e8:	d9840593          	addi	a1,s0,-616
  ec:	00001097          	auipc	ra,0x1
  f0:	8fa080e7          	jalr	-1798(ra) # 9e6 <fstat>
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
 128:	dbc50513          	addi	a0,a0,-580 # ee0 <malloc+0x11a>
 12c:	00001097          	auipc	ra,0x1
 130:	be2080e7          	jalr	-1054(ra) # d0e <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 134:	8526                	mv	a0,s1
 136:	00001097          	auipc	ra,0x1
 13a:	880080e7          	jalr	-1920(ra) # 9b6 <close>
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
 166:	d4e58593          	addi	a1,a1,-690 # eb0 <malloc+0xea>
 16a:	4509                	li	a0,2
 16c:	00001097          	auipc	ra,0x1
 170:	b74080e7          	jalr	-1164(ra) # ce0 <fprintf>
    return;
 174:	b7e9                	j	13e <ls+0x8a>
    fprintf(2, "ls: cannot stat %s\n", path);
 176:	864a                	mv	a2,s2
 178:	00001597          	auipc	a1,0x1
 17c:	d5058593          	addi	a1,a1,-688 # ec8 <malloc+0x102>
 180:	4509                	li	a0,2
 182:	00001097          	auipc	ra,0x1
 186:	b5e080e7          	jalr	-1186(ra) # ce0 <fprintf>
    close(fd);
 18a:	8526                	mv	a0,s1
 18c:	00001097          	auipc	ra,0x1
 190:	82a080e7          	jalr	-2006(ra) # 9b6 <close>
    return;
 194:	b76d                	j	13e <ls+0x8a>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 196:	854a                	mv	a0,s2
 198:	00000097          	auipc	ra,0x0
 19c:	5d2080e7          	jalr	1490(ra) # 76a <strlen>
 1a0:	2541                	addiw	a0,a0,16
 1a2:	20000793          	li	a5,512
 1a6:	00a7fb63          	bgeu	a5,a0,1bc <ls+0x108>
      printf("ls: path too long\n");
 1aa:	00001517          	auipc	a0,0x1
 1ae:	d4650513          	addi	a0,a0,-698 # ef0 <malloc+0x12a>
 1b2:	00001097          	auipc	ra,0x1
 1b6:	b5c080e7          	jalr	-1188(ra) # d0e <printf>
      break;
 1ba:	bfad                	j	134 <ls+0x80>
    strcpy(buf, path);
 1bc:	85ca                	mv	a1,s2
 1be:	dc040513          	addi	a0,s0,-576
 1c2:	00000097          	auipc	ra,0x0
 1c6:	560080e7          	jalr	1376(ra) # 722 <strcpy>
    p = buf+strlen(buf);
 1ca:	dc040513          	addi	a0,s0,-576
 1ce:	00000097          	auipc	ra,0x0
 1d2:	59c080e7          	jalr	1436(ra) # 76a <strlen>
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
 1f2:	d1aa0a13          	addi	s4,s4,-742 # f08 <malloc+0x142>
        printf("ls: cannot stat %s\n", buf);
 1f6:	00001a97          	auipc	s5,0x1
 1fa:	cd2a8a93          	addi	s5,s5,-814 # ec8 <malloc+0x102>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1fe:	a801                	j	20e <ls+0x15a>
        printf("ls: cannot stat %s\n", buf);
 200:	dc040593          	addi	a1,s0,-576
 204:	8556                	mv	a0,s5
 206:	00001097          	auipc	ra,0x1
 20a:	b08080e7          	jalr	-1272(ra) # d0e <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 20e:	4641                	li	a2,16
 210:	db040593          	addi	a1,s0,-592
 214:	8526                	mv	a0,s1
 216:	00000097          	auipc	ra,0x0
 21a:	790080e7          	jalr	1936(ra) # 9a6 <read>
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
 236:	6aa080e7          	jalr	1706(ra) # 8dc <memmove>
      p[DIRSIZ] = 0;
 23a:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 23e:	d9840593          	addi	a1,s0,-616
 242:	dc040513          	addi	a0,s0,-576
 246:	00000097          	auipc	ra,0x0
 24a:	608080e7          	jalr	1544(ra) # 84e <stat>
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
 272:	aa0080e7          	jalr	-1376(ra) # d0e <printf>
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
 2b4:	6de080e7          	jalr	1758(ra) # 98e <exit>
    ls(".");
 2b8:	00001517          	auipc	a0,0x1
 2bc:	c6050513          	addi	a0,a0,-928 # f18 <malloc+0x152>
 2c0:	00000097          	auipc	ra,0x0
 2c4:	df4080e7          	jalr	-524(ra) # b4 <ls>
    exit(0);
 2c8:	4501                	li	a0,0
 2ca:	00000097          	auipc	ra,0x0
 2ce:	6c4080e7          	jalr	1732(ra) # 98e <exit>

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
 306:	2dc080e7          	jalr	732(ra) # 5de <twhoami>
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
 352:	bd250513          	addi	a0,a0,-1070 # f20 <malloc+0x15a>
 356:	00001097          	auipc	ra,0x1
 35a:	9b8080e7          	jalr	-1608(ra) # d0e <printf>
        exit(-1);
 35e:	557d                	li	a0,-1
 360:	00000097          	auipc	ra,0x0
 364:	62e080e7          	jalr	1582(ra) # 98e <exit>
    {
        // give up the cpu for other threads
        tyield();
 368:	00000097          	auipc	ra,0x0
 36c:	252080e7          	jalr	594(ra) # 5ba <tyield>
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
 386:	25c080e7          	jalr	604(ra) # 5de <twhoami>
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
 3ca:	1f4080e7          	jalr	500(ra) # 5ba <tyield>
}
 3ce:	60e2                	ld	ra,24(sp)
 3d0:	6442                	ld	s0,16(sp)
 3d2:	64a2                	ld	s1,8(sp)
 3d4:	6105                	addi	sp,sp,32
 3d6:	8082                	ret
        printf("releasing lock we are not holding");
 3d8:	00001517          	auipc	a0,0x1
 3dc:	b7050513          	addi	a0,a0,-1168 # f48 <malloc+0x182>
 3e0:	00001097          	auipc	ra,0x1
 3e4:	92e080e7          	jalr	-1746(ra) # d0e <printf>
        exit(-1);
 3e8:	557d                	li	a0,-1
 3ea:	00000097          	auipc	ra,0x0
 3ee:	5a4080e7          	jalr	1444(ra) # 98e <exit>

00000000000003f2 <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
 3f2:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 3f4:	00002617          	auipc	a2,0x2
 3f8:	c3c60613          	addi	a2,a2,-964 # 2030 <threads>
 3fc:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
 3fe:	45c1                	li	a1,16
 400:	a021                	j	408 <tsched+0x16>
 402:	2685                	addiw	a3,a3,1
 404:	08b68c63          	beq	a3,a1,49c <tsched+0xaa>
        int next_index = (current_index + i) % 16;
 408:	41f6d71b          	sraiw	a4,a3,0x1f
 40c:	01c7571b          	srliw	a4,a4,0x1c
 410:	00d707bb          	addw	a5,a4,a3
 414:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 416:	9f99                	subw	a5,a5,a4
 418:	078e                	slli	a5,a5,0x3
 41a:	97b2                	add	a5,a5,a2
 41c:	639c                	ld	a5,0(a5)
 41e:	d3f5                	beqz	a5,402 <tsched+0x10>
 420:	5fb8                	lw	a4,120(a5)
 422:	fea710e3          	bne	a4,a0,402 <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
 426:	00002717          	auipc	a4,0x2
 42a:	c0a73703          	ld	a4,-1014(a4) # 2030 <threads>
 42e:	5f30                	lw	a2,120(a4)
 430:	468d                	li	a3,3
 432:	06d60363          	beq	a2,a3,498 <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
 436:	c3a5                	beqz	a5,496 <tsched+0xa4>
{
 438:	1101                	addi	sp,sp,-32
 43a:	ec06                	sd	ra,24(sp)
 43c:	e822                	sd	s0,16(sp)
 43e:	e426                	sd	s1,8(sp)
 440:	e04a                	sd	s2,0(sp)
 442:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
 444:	00002497          	auipc	s1,0x2
 448:	bcc48493          	addi	s1,s1,-1076 # 2010 <current_thread>
 44c:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
 450:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
 452:	0007c603          	lbu	a2,0(a5)
 456:	00094583          	lbu	a1,0(s2)
 45a:	00001517          	auipc	a0,0x1
 45e:	b1650513          	addi	a0,a0,-1258 # f70 <malloc+0x1aa>
 462:	00001097          	auipc	ra,0x1
 466:	8ac080e7          	jalr	-1876(ra) # d0e <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 46a:	608c                	ld	a1,0(s1)
 46c:	05a1                	addi	a1,a1,8
 46e:	00890513          	addi	a0,s2,8
 472:	00000097          	auipc	ra,0x0
 476:	184080e7          	jalr	388(ra) # 5f6 <tswtch>
        printf("Thread switch complete\n");
 47a:	00001517          	auipc	a0,0x1
 47e:	b1e50513          	addi	a0,a0,-1250 # f98 <malloc+0x1d2>
 482:	00001097          	auipc	ra,0x1
 486:	88c080e7          	jalr	-1908(ra) # d0e <printf>
    }
}
 48a:	60e2                	ld	ra,24(sp)
 48c:	6442                	ld	s0,16(sp)
 48e:	64a2                	ld	s1,8(sp)
 490:	6902                	ld	s2,0(sp)
 492:	6105                	addi	sp,sp,32
 494:	8082                	ret
 496:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
 498:	87ba                	mv	a5,a4
 49a:	bf79                	j	438 <tsched+0x46>
 49c:	00002797          	auipc	a5,0x2
 4a0:	b947b783          	ld	a5,-1132(a5) # 2030 <threads>
 4a4:	5fb4                	lw	a3,120(a5)
 4a6:	470d                	li	a4,3
 4a8:	f8e688e3          	beq	a3,a4,438 <tsched+0x46>
 4ac:	8082                	ret

00000000000004ae <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 4ae:	7179                	addi	sp,sp,-48
 4b0:	f406                	sd	ra,40(sp)
 4b2:	f022                	sd	s0,32(sp)
 4b4:	ec26                	sd	s1,24(sp)
 4b6:	e84a                	sd	s2,16(sp)
 4b8:	e44e                	sd	s3,8(sp)
 4ba:	1800                	addi	s0,sp,48
 4bc:	84aa                	mv	s1,a0
 4be:	89b2                	mv	s3,a2
 4c0:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 4c2:	09000513          	li	a0,144
 4c6:	00001097          	auipc	ra,0x1
 4ca:	900080e7          	jalr	-1792(ra) # dc6 <malloc>
 4ce:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 4d0:	478d                	li	a5,3
 4d2:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 4d4:	609c                	ld	a5,0(s1)
 4d6:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 4da:	609c                	ld	a5,0(s1)
 4dc:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
 4e0:	00002717          	auipc	a4,0x2
 4e4:	b2070713          	addi	a4,a4,-1248 # 2000 <next_tid>
 4e8:	431c                	lw	a5,0(a4)
 4ea:	0017869b          	addiw	a3,a5,1
 4ee:	c314                	sw	a3,0(a4)
 4f0:	6098                	ld	a4,0(s1)
 4f2:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
 4f6:	00002717          	auipc	a4,0x2
 4fa:	b3a70713          	addi	a4,a4,-1222 # 2030 <threads>
 4fe:	4781                	li	a5,0
 500:	4641                	li	a2,16
    if (threads[i] == NULL) {
 502:	6314                	ld	a3,0(a4)
 504:	ce81                	beqz	a3,51c <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
 506:	2785                	addiw	a5,a5,1
 508:	0721                	addi	a4,a4,8
 50a:	fec79ce3          	bne	a5,a2,502 <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
 50e:	70a2                	ld	ra,40(sp)
 510:	7402                	ld	s0,32(sp)
 512:	64e2                	ld	s1,24(sp)
 514:	6942                	ld	s2,16(sp)
 516:	69a2                	ld	s3,8(sp)
 518:	6145                	addi	sp,sp,48
 51a:	8082                	ret
        threads[i] = *thread;
 51c:	6094                	ld	a3,0(s1)
 51e:	078e                	slli	a5,a5,0x3
 520:	00002717          	auipc	a4,0x2
 524:	b1070713          	addi	a4,a4,-1264 # 2030 <threads>
 528:	97ba                	add	a5,a5,a4
 52a:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
 52c:	0006c583          	lbu	a1,0(a3)
 530:	00001517          	auipc	a0,0x1
 534:	a8050513          	addi	a0,a0,-1408 # fb0 <malloc+0x1ea>
 538:	00000097          	auipc	ra,0x0
 53c:	7d6080e7          	jalr	2006(ra) # d0e <printf>
        break;
 540:	b7f9                	j	50e <tcreate+0x60>

0000000000000542 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 542:	7179                	addi	sp,sp,-48
 544:	f406                	sd	ra,40(sp)
 546:	f022                	sd	s0,32(sp)
 548:	ec26                	sd	s1,24(sp)
 54a:	e84a                	sd	s2,16(sp)
 54c:	e44e                	sd	s3,8(sp)
 54e:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
 550:	00002797          	auipc	a5,0x2
 554:	ae078793          	addi	a5,a5,-1312 # 2030 <threads>
 558:	00002697          	auipc	a3,0x2
 55c:	b5868693          	addi	a3,a3,-1192 # 20b0 <base>
 560:	a021                	j	568 <tjoin+0x26>
 562:	07a1                	addi	a5,a5,8
 564:	04d78763          	beq	a5,a3,5b2 <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
 568:	6384                	ld	s1,0(a5)
 56a:	dce5                	beqz	s1,562 <tjoin+0x20>
 56c:	0004c703          	lbu	a4,0(s1)
 570:	fea719e3          	bne	a4,a0,562 <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
 574:	5cb8                	lw	a4,120(s1)
 576:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 578:	00001997          	auipc	s3,0x1
 57c:	a6898993          	addi	s3,s3,-1432 # fe0 <malloc+0x21a>
    while (target_thread->state != EXITED) {
 580:	4919                	li	s2,6
 582:	02f70a63          	beq	a4,a5,5b6 <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 586:	0004c583          	lbu	a1,0(s1)
 58a:	854e                	mv	a0,s3
 58c:	00000097          	auipc	ra,0x0
 590:	782080e7          	jalr	1922(ra) # d0e <printf>
        tsched();
 594:	00000097          	auipc	ra,0x0
 598:	e5e080e7          	jalr	-418(ra) # 3f2 <tsched>
    while (target_thread->state != EXITED) {
 59c:	5cbc                	lw	a5,120(s1)
 59e:	ff2794e3          	bne	a5,s2,586 <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
 5a2:	4501                	li	a0,0
}
 5a4:	70a2                	ld	ra,40(sp)
 5a6:	7402                	ld	s0,32(sp)
 5a8:	64e2                	ld	s1,24(sp)
 5aa:	6942                	ld	s2,16(sp)
 5ac:	69a2                	ld	s3,8(sp)
 5ae:	6145                	addi	sp,sp,48
 5b0:	8082                	ret
        return -1;
 5b2:	557d                	li	a0,-1
 5b4:	bfc5                	j	5a4 <tjoin+0x62>
    return 0;
 5b6:	4501                	li	a0,0
 5b8:	b7f5                	j	5a4 <tjoin+0x62>

00000000000005ba <tyield>:


void tyield()
{
 5ba:	1141                	addi	sp,sp,-16
 5bc:	e406                	sd	ra,8(sp)
 5be:	e022                	sd	s0,0(sp)
 5c0:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 5c2:	00002797          	auipc	a5,0x2
 5c6:	a4e7b783          	ld	a5,-1458(a5) # 2010 <current_thread>
 5ca:	470d                	li	a4,3
 5cc:	dfb8                	sw	a4,120(a5)
    tsched();
 5ce:	00000097          	auipc	ra,0x0
 5d2:	e24080e7          	jalr	-476(ra) # 3f2 <tsched>
}
 5d6:	60a2                	ld	ra,8(sp)
 5d8:	6402                	ld	s0,0(sp)
 5da:	0141                	addi	sp,sp,16
 5dc:	8082                	ret

00000000000005de <twhoami>:

uint8 twhoami()
{
 5de:	1141                	addi	sp,sp,-16
 5e0:	e422                	sd	s0,8(sp)
 5e2:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
 5e4:	00002797          	auipc	a5,0x2
 5e8:	a2c7b783          	ld	a5,-1492(a5) # 2010 <current_thread>
 5ec:	0007c503          	lbu	a0,0(a5)
 5f0:	6422                	ld	s0,8(sp)
 5f2:	0141                	addi	sp,sp,16
 5f4:	8082                	ret

00000000000005f6 <tswtch>:
 5f6:	00153023          	sd	ra,0(a0)
 5fa:	00253423          	sd	sp,8(a0)
 5fe:	e900                	sd	s0,16(a0)
 600:	ed04                	sd	s1,24(a0)
 602:	03253023          	sd	s2,32(a0)
 606:	03353423          	sd	s3,40(a0)
 60a:	03453823          	sd	s4,48(a0)
 60e:	03553c23          	sd	s5,56(a0)
 612:	05653023          	sd	s6,64(a0)
 616:	05753423          	sd	s7,72(a0)
 61a:	05853823          	sd	s8,80(a0)
 61e:	05953c23          	sd	s9,88(a0)
 622:	07a53023          	sd	s10,96(a0)
 626:	07b53423          	sd	s11,104(a0)
 62a:	0005b083          	ld	ra,0(a1)
 62e:	0085b103          	ld	sp,8(a1)
 632:	6980                	ld	s0,16(a1)
 634:	6d84                	ld	s1,24(a1)
 636:	0205b903          	ld	s2,32(a1)
 63a:	0285b983          	ld	s3,40(a1)
 63e:	0305ba03          	ld	s4,48(a1)
 642:	0385ba83          	ld	s5,56(a1)
 646:	0405bb03          	ld	s6,64(a1)
 64a:	0485bb83          	ld	s7,72(a1)
 64e:	0505bc03          	ld	s8,80(a1)
 652:	0585bc83          	ld	s9,88(a1)
 656:	0605bd03          	ld	s10,96(a1)
 65a:	0685bd83          	ld	s11,104(a1)
 65e:	8082                	ret

0000000000000660 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 660:	715d                	addi	sp,sp,-80
 662:	e486                	sd	ra,72(sp)
 664:	e0a2                	sd	s0,64(sp)
 666:	fc26                	sd	s1,56(sp)
 668:	f84a                	sd	s2,48(sp)
 66a:	f44e                	sd	s3,40(sp)
 66c:	f052                	sd	s4,32(sp)
 66e:	ec56                	sd	s5,24(sp)
 670:	e85a                	sd	s6,16(sp)
 672:	e45e                	sd	s7,8(sp)
 674:	0880                	addi	s0,sp,80
 676:	892a                	mv	s2,a0
 678:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
 67a:	00001517          	auipc	a0,0x1
 67e:	98650513          	addi	a0,a0,-1658 # 1000 <malloc+0x23a>
 682:	00000097          	auipc	ra,0x0
 686:	68c080e7          	jalr	1676(ra) # d0e <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 68a:	09000513          	li	a0,144
 68e:	00000097          	auipc	ra,0x0
 692:	738080e7          	jalr	1848(ra) # dc6 <malloc>

    main_thread->tid = 0;
 696:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
 69a:	4791                	li	a5,4
 69c:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 69e:	00002797          	auipc	a5,0x2
 6a2:	96a7b923          	sd	a0,-1678(a5) # 2010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 6a6:	00002a17          	auipc	s4,0x2
 6aa:	98aa0a13          	addi	s4,s4,-1654 # 2030 <threads>
 6ae:	00002497          	auipc	s1,0x2
 6b2:	a0248493          	addi	s1,s1,-1534 # 20b0 <base>
    current_thread = main_thread;
 6b6:	87d2                	mv	a5,s4
        threads[i] = NULL;
 6b8:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 6bc:	07a1                	addi	a5,a5,8
 6be:	fe979de3          	bne	a5,s1,6b8 <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 6c2:	00002797          	auipc	a5,0x2
 6c6:	96a7b723          	sd	a0,-1682(a5) # 2030 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 6ca:	85ce                	mv	a1,s3
 6cc:	854a                	mv	a0,s2
 6ce:	00000097          	auipc	ra,0x0
 6d2:	baa080e7          	jalr	-1110(ra) # 278 <main>
 6d6:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
 6d8:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 6da:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
 6dc:	00001a97          	auipc	s5,0x1
 6e0:	944a8a93          	addi	s5,s5,-1724 # 1020 <malloc+0x25a>
 6e4:	a03d                	j	712 <_main+0xb2>
        for (int i = 0; i < 16; i++) {
 6e6:	07a1                	addi	a5,a5,8
 6e8:	00978963          	beq	a5,s1,6fa <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 6ec:	6398                	ld	a4,0(a5)
 6ee:	df65                	beqz	a4,6e6 <_main+0x86>
 6f0:	5f38                	lw	a4,120(a4)
 6f2:	ff370ae3          	beq	a4,s3,6e6 <_main+0x86>
                running_threads++;
 6f6:	2905                	addiw	s2,s2,1
 6f8:	b7fd                	j	6e6 <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
 6fa:	85ca                	mv	a1,s2
 6fc:	8556                	mv	a0,s5
 6fe:	00000097          	auipc	ra,0x0
 702:	610080e7          	jalr	1552(ra) # d0e <printf>
        if (running_threads > 0) {
 706:	01205963          	blez	s2,718 <_main+0xb8>
            tsched(); // Schedule another thread to run
 70a:	00000097          	auipc	ra,0x0
 70e:	ce8080e7          	jalr	-792(ra) # 3f2 <tsched>
    current_thread = main_thread;
 712:	87d2                	mv	a5,s4
        running_threads = 0;
 714:	895a                	mv	s2,s6
 716:	bfd9                	j	6ec <_main+0x8c>
        }
    }

    exit(res);
 718:	855e                	mv	a0,s7
 71a:	00000097          	auipc	ra,0x0
 71e:	274080e7          	jalr	628(ra) # 98e <exit>

0000000000000722 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 722:	1141                	addi	sp,sp,-16
 724:	e422                	sd	s0,8(sp)
 726:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 728:	87aa                	mv	a5,a0
 72a:	0585                	addi	a1,a1,1
 72c:	0785                	addi	a5,a5,1
 72e:	fff5c703          	lbu	a4,-1(a1)
 732:	fee78fa3          	sb	a4,-1(a5)
 736:	fb75                	bnez	a4,72a <strcpy+0x8>
        ;
    return os;
}
 738:	6422                	ld	s0,8(sp)
 73a:	0141                	addi	sp,sp,16
 73c:	8082                	ret

000000000000073e <strcmp>:

int strcmp(const char *p, const char *q)
{
 73e:	1141                	addi	sp,sp,-16
 740:	e422                	sd	s0,8(sp)
 742:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 744:	00054783          	lbu	a5,0(a0)
 748:	cb91                	beqz	a5,75c <strcmp+0x1e>
 74a:	0005c703          	lbu	a4,0(a1)
 74e:	00f71763          	bne	a4,a5,75c <strcmp+0x1e>
        p++, q++;
 752:	0505                	addi	a0,a0,1
 754:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 756:	00054783          	lbu	a5,0(a0)
 75a:	fbe5                	bnez	a5,74a <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 75c:	0005c503          	lbu	a0,0(a1)
}
 760:	40a7853b          	subw	a0,a5,a0
 764:	6422                	ld	s0,8(sp)
 766:	0141                	addi	sp,sp,16
 768:	8082                	ret

000000000000076a <strlen>:

uint strlen(const char *s)
{
 76a:	1141                	addi	sp,sp,-16
 76c:	e422                	sd	s0,8(sp)
 76e:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 770:	00054783          	lbu	a5,0(a0)
 774:	cf91                	beqz	a5,790 <strlen+0x26>
 776:	0505                	addi	a0,a0,1
 778:	87aa                	mv	a5,a0
 77a:	86be                	mv	a3,a5
 77c:	0785                	addi	a5,a5,1
 77e:	fff7c703          	lbu	a4,-1(a5)
 782:	ff65                	bnez	a4,77a <strlen+0x10>
 784:	40a6853b          	subw	a0,a3,a0
 788:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 78a:	6422                	ld	s0,8(sp)
 78c:	0141                	addi	sp,sp,16
 78e:	8082                	ret
    for (n = 0; s[n]; n++)
 790:	4501                	li	a0,0
 792:	bfe5                	j	78a <strlen+0x20>

0000000000000794 <memset>:

void *
memset(void *dst, int c, uint n)
{
 794:	1141                	addi	sp,sp,-16
 796:	e422                	sd	s0,8(sp)
 798:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 79a:	ca19                	beqz	a2,7b0 <memset+0x1c>
 79c:	87aa                	mv	a5,a0
 79e:	1602                	slli	a2,a2,0x20
 7a0:	9201                	srli	a2,a2,0x20
 7a2:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 7a6:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 7aa:	0785                	addi	a5,a5,1
 7ac:	fee79de3          	bne	a5,a4,7a6 <memset+0x12>
    }
    return dst;
}
 7b0:	6422                	ld	s0,8(sp)
 7b2:	0141                	addi	sp,sp,16
 7b4:	8082                	ret

00000000000007b6 <strchr>:

char *
strchr(const char *s, char c)
{
 7b6:	1141                	addi	sp,sp,-16
 7b8:	e422                	sd	s0,8(sp)
 7ba:	0800                	addi	s0,sp,16
    for (; *s; s++)
 7bc:	00054783          	lbu	a5,0(a0)
 7c0:	cb99                	beqz	a5,7d6 <strchr+0x20>
        if (*s == c)
 7c2:	00f58763          	beq	a1,a5,7d0 <strchr+0x1a>
    for (; *s; s++)
 7c6:	0505                	addi	a0,a0,1
 7c8:	00054783          	lbu	a5,0(a0)
 7cc:	fbfd                	bnez	a5,7c2 <strchr+0xc>
            return (char *)s;
    return 0;
 7ce:	4501                	li	a0,0
}
 7d0:	6422                	ld	s0,8(sp)
 7d2:	0141                	addi	sp,sp,16
 7d4:	8082                	ret
    return 0;
 7d6:	4501                	li	a0,0
 7d8:	bfe5                	j	7d0 <strchr+0x1a>

00000000000007da <gets>:

char *
gets(char *buf, int max)
{
 7da:	711d                	addi	sp,sp,-96
 7dc:	ec86                	sd	ra,88(sp)
 7de:	e8a2                	sd	s0,80(sp)
 7e0:	e4a6                	sd	s1,72(sp)
 7e2:	e0ca                	sd	s2,64(sp)
 7e4:	fc4e                	sd	s3,56(sp)
 7e6:	f852                	sd	s4,48(sp)
 7e8:	f456                	sd	s5,40(sp)
 7ea:	f05a                	sd	s6,32(sp)
 7ec:	ec5e                	sd	s7,24(sp)
 7ee:	1080                	addi	s0,sp,96
 7f0:	8baa                	mv	s7,a0
 7f2:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 7f4:	892a                	mv	s2,a0
 7f6:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 7f8:	4aa9                	li	s5,10
 7fa:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 7fc:	89a6                	mv	s3,s1
 7fe:	2485                	addiw	s1,s1,1
 800:	0344d863          	bge	s1,s4,830 <gets+0x56>
        cc = read(0, &c, 1);
 804:	4605                	li	a2,1
 806:	faf40593          	addi	a1,s0,-81
 80a:	4501                	li	a0,0
 80c:	00000097          	auipc	ra,0x0
 810:	19a080e7          	jalr	410(ra) # 9a6 <read>
        if (cc < 1)
 814:	00a05e63          	blez	a0,830 <gets+0x56>
        buf[i++] = c;
 818:	faf44783          	lbu	a5,-81(s0)
 81c:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 820:	01578763          	beq	a5,s5,82e <gets+0x54>
 824:	0905                	addi	s2,s2,1
 826:	fd679be3          	bne	a5,s6,7fc <gets+0x22>
    for (i = 0; i + 1 < max;)
 82a:	89a6                	mv	s3,s1
 82c:	a011                	j	830 <gets+0x56>
 82e:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 830:	99de                	add	s3,s3,s7
 832:	00098023          	sb	zero,0(s3)
    return buf;
}
 836:	855e                	mv	a0,s7
 838:	60e6                	ld	ra,88(sp)
 83a:	6446                	ld	s0,80(sp)
 83c:	64a6                	ld	s1,72(sp)
 83e:	6906                	ld	s2,64(sp)
 840:	79e2                	ld	s3,56(sp)
 842:	7a42                	ld	s4,48(sp)
 844:	7aa2                	ld	s5,40(sp)
 846:	7b02                	ld	s6,32(sp)
 848:	6be2                	ld	s7,24(sp)
 84a:	6125                	addi	sp,sp,96
 84c:	8082                	ret

000000000000084e <stat>:

int stat(const char *n, struct stat *st)
{
 84e:	1101                	addi	sp,sp,-32
 850:	ec06                	sd	ra,24(sp)
 852:	e822                	sd	s0,16(sp)
 854:	e426                	sd	s1,8(sp)
 856:	e04a                	sd	s2,0(sp)
 858:	1000                	addi	s0,sp,32
 85a:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 85c:	4581                	li	a1,0
 85e:	00000097          	auipc	ra,0x0
 862:	170080e7          	jalr	368(ra) # 9ce <open>
    if (fd < 0)
 866:	02054563          	bltz	a0,890 <stat+0x42>
 86a:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 86c:	85ca                	mv	a1,s2
 86e:	00000097          	auipc	ra,0x0
 872:	178080e7          	jalr	376(ra) # 9e6 <fstat>
 876:	892a                	mv	s2,a0
    close(fd);
 878:	8526                	mv	a0,s1
 87a:	00000097          	auipc	ra,0x0
 87e:	13c080e7          	jalr	316(ra) # 9b6 <close>
    return r;
}
 882:	854a                	mv	a0,s2
 884:	60e2                	ld	ra,24(sp)
 886:	6442                	ld	s0,16(sp)
 888:	64a2                	ld	s1,8(sp)
 88a:	6902                	ld	s2,0(sp)
 88c:	6105                	addi	sp,sp,32
 88e:	8082                	ret
        return -1;
 890:	597d                	li	s2,-1
 892:	bfc5                	j	882 <stat+0x34>

0000000000000894 <atoi>:

int atoi(const char *s)
{
 894:	1141                	addi	sp,sp,-16
 896:	e422                	sd	s0,8(sp)
 898:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 89a:	00054683          	lbu	a3,0(a0)
 89e:	fd06879b          	addiw	a5,a3,-48
 8a2:	0ff7f793          	zext.b	a5,a5
 8a6:	4625                	li	a2,9
 8a8:	02f66863          	bltu	a2,a5,8d8 <atoi+0x44>
 8ac:	872a                	mv	a4,a0
    n = 0;
 8ae:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 8b0:	0705                	addi	a4,a4,1
 8b2:	0025179b          	slliw	a5,a0,0x2
 8b6:	9fa9                	addw	a5,a5,a0
 8b8:	0017979b          	slliw	a5,a5,0x1
 8bc:	9fb5                	addw	a5,a5,a3
 8be:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 8c2:	00074683          	lbu	a3,0(a4)
 8c6:	fd06879b          	addiw	a5,a3,-48
 8ca:	0ff7f793          	zext.b	a5,a5
 8ce:	fef671e3          	bgeu	a2,a5,8b0 <atoi+0x1c>
    return n;
}
 8d2:	6422                	ld	s0,8(sp)
 8d4:	0141                	addi	sp,sp,16
 8d6:	8082                	ret
    n = 0;
 8d8:	4501                	li	a0,0
 8da:	bfe5                	j	8d2 <atoi+0x3e>

00000000000008dc <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 8dc:	1141                	addi	sp,sp,-16
 8de:	e422                	sd	s0,8(sp)
 8e0:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 8e2:	02b57463          	bgeu	a0,a1,90a <memmove+0x2e>
    {
        while (n-- > 0)
 8e6:	00c05f63          	blez	a2,904 <memmove+0x28>
 8ea:	1602                	slli	a2,a2,0x20
 8ec:	9201                	srli	a2,a2,0x20
 8ee:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 8f2:	872a                	mv	a4,a0
            *dst++ = *src++;
 8f4:	0585                	addi	a1,a1,1
 8f6:	0705                	addi	a4,a4,1
 8f8:	fff5c683          	lbu	a3,-1(a1)
 8fc:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 900:	fee79ae3          	bne	a5,a4,8f4 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 904:	6422                	ld	s0,8(sp)
 906:	0141                	addi	sp,sp,16
 908:	8082                	ret
        dst += n;
 90a:	00c50733          	add	a4,a0,a2
        src += n;
 90e:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 910:	fec05ae3          	blez	a2,904 <memmove+0x28>
 914:	fff6079b          	addiw	a5,a2,-1
 918:	1782                	slli	a5,a5,0x20
 91a:	9381                	srli	a5,a5,0x20
 91c:	fff7c793          	not	a5,a5
 920:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 922:	15fd                	addi	a1,a1,-1
 924:	177d                	addi	a4,a4,-1
 926:	0005c683          	lbu	a3,0(a1)
 92a:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 92e:	fee79ae3          	bne	a5,a4,922 <memmove+0x46>
 932:	bfc9                	j	904 <memmove+0x28>

0000000000000934 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 934:	1141                	addi	sp,sp,-16
 936:	e422                	sd	s0,8(sp)
 938:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 93a:	ca05                	beqz	a2,96a <memcmp+0x36>
 93c:	fff6069b          	addiw	a3,a2,-1
 940:	1682                	slli	a3,a3,0x20
 942:	9281                	srli	a3,a3,0x20
 944:	0685                	addi	a3,a3,1
 946:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 948:	00054783          	lbu	a5,0(a0)
 94c:	0005c703          	lbu	a4,0(a1)
 950:	00e79863          	bne	a5,a4,960 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 954:	0505                	addi	a0,a0,1
        p2++;
 956:	0585                	addi	a1,a1,1
    while (n-- > 0)
 958:	fed518e3          	bne	a0,a3,948 <memcmp+0x14>
    }
    return 0;
 95c:	4501                	li	a0,0
 95e:	a019                	j	964 <memcmp+0x30>
            return *p1 - *p2;
 960:	40e7853b          	subw	a0,a5,a4
}
 964:	6422                	ld	s0,8(sp)
 966:	0141                	addi	sp,sp,16
 968:	8082                	ret
    return 0;
 96a:	4501                	li	a0,0
 96c:	bfe5                	j	964 <memcmp+0x30>

000000000000096e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 96e:	1141                	addi	sp,sp,-16
 970:	e406                	sd	ra,8(sp)
 972:	e022                	sd	s0,0(sp)
 974:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 976:	00000097          	auipc	ra,0x0
 97a:	f66080e7          	jalr	-154(ra) # 8dc <memmove>
}
 97e:	60a2                	ld	ra,8(sp)
 980:	6402                	ld	s0,0(sp)
 982:	0141                	addi	sp,sp,16
 984:	8082                	ret

0000000000000986 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 986:	4885                	li	a7,1
 ecall
 988:	00000073          	ecall
 ret
 98c:	8082                	ret

000000000000098e <exit>:
.global exit
exit:
 li a7, SYS_exit
 98e:	4889                	li	a7,2
 ecall
 990:	00000073          	ecall
 ret
 994:	8082                	ret

0000000000000996 <wait>:
.global wait
wait:
 li a7, SYS_wait
 996:	488d                	li	a7,3
 ecall
 998:	00000073          	ecall
 ret
 99c:	8082                	ret

000000000000099e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 99e:	4891                	li	a7,4
 ecall
 9a0:	00000073          	ecall
 ret
 9a4:	8082                	ret

00000000000009a6 <read>:
.global read
read:
 li a7, SYS_read
 9a6:	4895                	li	a7,5
 ecall
 9a8:	00000073          	ecall
 ret
 9ac:	8082                	ret

00000000000009ae <write>:
.global write
write:
 li a7, SYS_write
 9ae:	48c1                	li	a7,16
 ecall
 9b0:	00000073          	ecall
 ret
 9b4:	8082                	ret

00000000000009b6 <close>:
.global close
close:
 li a7, SYS_close
 9b6:	48d5                	li	a7,21
 ecall
 9b8:	00000073          	ecall
 ret
 9bc:	8082                	ret

00000000000009be <kill>:
.global kill
kill:
 li a7, SYS_kill
 9be:	4899                	li	a7,6
 ecall
 9c0:	00000073          	ecall
 ret
 9c4:	8082                	ret

00000000000009c6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 9c6:	489d                	li	a7,7
 ecall
 9c8:	00000073          	ecall
 ret
 9cc:	8082                	ret

00000000000009ce <open>:
.global open
open:
 li a7, SYS_open
 9ce:	48bd                	li	a7,15
 ecall
 9d0:	00000073          	ecall
 ret
 9d4:	8082                	ret

00000000000009d6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 9d6:	48c5                	li	a7,17
 ecall
 9d8:	00000073          	ecall
 ret
 9dc:	8082                	ret

00000000000009de <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 9de:	48c9                	li	a7,18
 ecall
 9e0:	00000073          	ecall
 ret
 9e4:	8082                	ret

00000000000009e6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 9e6:	48a1                	li	a7,8
 ecall
 9e8:	00000073          	ecall
 ret
 9ec:	8082                	ret

00000000000009ee <link>:
.global link
link:
 li a7, SYS_link
 9ee:	48cd                	li	a7,19
 ecall
 9f0:	00000073          	ecall
 ret
 9f4:	8082                	ret

00000000000009f6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 9f6:	48d1                	li	a7,20
 ecall
 9f8:	00000073          	ecall
 ret
 9fc:	8082                	ret

00000000000009fe <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 9fe:	48a5                	li	a7,9
 ecall
 a00:	00000073          	ecall
 ret
 a04:	8082                	ret

0000000000000a06 <dup>:
.global dup
dup:
 li a7, SYS_dup
 a06:	48a9                	li	a7,10
 ecall
 a08:	00000073          	ecall
 ret
 a0c:	8082                	ret

0000000000000a0e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 a0e:	48ad                	li	a7,11
 ecall
 a10:	00000073          	ecall
 ret
 a14:	8082                	ret

0000000000000a16 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 a16:	48b1                	li	a7,12
 ecall
 a18:	00000073          	ecall
 ret
 a1c:	8082                	ret

0000000000000a1e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 a1e:	48b5                	li	a7,13
 ecall
 a20:	00000073          	ecall
 ret
 a24:	8082                	ret

0000000000000a26 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 a26:	48b9                	li	a7,14
 ecall
 a28:	00000073          	ecall
 ret
 a2c:	8082                	ret

0000000000000a2e <ps>:
.global ps
ps:
 li a7, SYS_ps
 a2e:	48d9                	li	a7,22
 ecall
 a30:	00000073          	ecall
 ret
 a34:	8082                	ret

0000000000000a36 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 a36:	48dd                	li	a7,23
 ecall
 a38:	00000073          	ecall
 ret
 a3c:	8082                	ret

0000000000000a3e <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 a3e:	48e1                	li	a7,24
 ecall
 a40:	00000073          	ecall
 ret
 a44:	8082                	ret

0000000000000a46 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 a46:	1101                	addi	sp,sp,-32
 a48:	ec06                	sd	ra,24(sp)
 a4a:	e822                	sd	s0,16(sp)
 a4c:	1000                	addi	s0,sp,32
 a4e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 a52:	4605                	li	a2,1
 a54:	fef40593          	addi	a1,s0,-17
 a58:	00000097          	auipc	ra,0x0
 a5c:	f56080e7          	jalr	-170(ra) # 9ae <write>
}
 a60:	60e2                	ld	ra,24(sp)
 a62:	6442                	ld	s0,16(sp)
 a64:	6105                	addi	sp,sp,32
 a66:	8082                	ret

0000000000000a68 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 a68:	7139                	addi	sp,sp,-64
 a6a:	fc06                	sd	ra,56(sp)
 a6c:	f822                	sd	s0,48(sp)
 a6e:	f426                	sd	s1,40(sp)
 a70:	f04a                	sd	s2,32(sp)
 a72:	ec4e                	sd	s3,24(sp)
 a74:	0080                	addi	s0,sp,64
 a76:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 a78:	c299                	beqz	a3,a7e <printint+0x16>
 a7a:	0805c963          	bltz	a1,b0c <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 a7e:	2581                	sext.w	a1,a1
  neg = 0;
 a80:	4881                	li	a7,0
 a82:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 a86:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 a88:	2601                	sext.w	a2,a2
 a8a:	00000517          	auipc	a0,0x0
 a8e:	61650513          	addi	a0,a0,1558 # 10a0 <digits>
 a92:	883a                	mv	a6,a4
 a94:	2705                	addiw	a4,a4,1
 a96:	02c5f7bb          	remuw	a5,a1,a2
 a9a:	1782                	slli	a5,a5,0x20
 a9c:	9381                	srli	a5,a5,0x20
 a9e:	97aa                	add	a5,a5,a0
 aa0:	0007c783          	lbu	a5,0(a5)
 aa4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 aa8:	0005879b          	sext.w	a5,a1
 aac:	02c5d5bb          	divuw	a1,a1,a2
 ab0:	0685                	addi	a3,a3,1
 ab2:	fec7f0e3          	bgeu	a5,a2,a92 <printint+0x2a>
  if(neg)
 ab6:	00088c63          	beqz	a7,ace <printint+0x66>
    buf[i++] = '-';
 aba:	fd070793          	addi	a5,a4,-48
 abe:	00878733          	add	a4,a5,s0
 ac2:	02d00793          	li	a5,45
 ac6:	fef70823          	sb	a5,-16(a4)
 aca:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 ace:	02e05863          	blez	a4,afe <printint+0x96>
 ad2:	fc040793          	addi	a5,s0,-64
 ad6:	00e78933          	add	s2,a5,a4
 ada:	fff78993          	addi	s3,a5,-1
 ade:	99ba                	add	s3,s3,a4
 ae0:	377d                	addiw	a4,a4,-1
 ae2:	1702                	slli	a4,a4,0x20
 ae4:	9301                	srli	a4,a4,0x20
 ae6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 aea:	fff94583          	lbu	a1,-1(s2)
 aee:	8526                	mv	a0,s1
 af0:	00000097          	auipc	ra,0x0
 af4:	f56080e7          	jalr	-170(ra) # a46 <putc>
  while(--i >= 0)
 af8:	197d                	addi	s2,s2,-1
 afa:	ff3918e3          	bne	s2,s3,aea <printint+0x82>
}
 afe:	70e2                	ld	ra,56(sp)
 b00:	7442                	ld	s0,48(sp)
 b02:	74a2                	ld	s1,40(sp)
 b04:	7902                	ld	s2,32(sp)
 b06:	69e2                	ld	s3,24(sp)
 b08:	6121                	addi	sp,sp,64
 b0a:	8082                	ret
    x = -xx;
 b0c:	40b005bb          	negw	a1,a1
    neg = 1;
 b10:	4885                	li	a7,1
    x = -xx;
 b12:	bf85                	j	a82 <printint+0x1a>

0000000000000b14 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 b14:	715d                	addi	sp,sp,-80
 b16:	e486                	sd	ra,72(sp)
 b18:	e0a2                	sd	s0,64(sp)
 b1a:	fc26                	sd	s1,56(sp)
 b1c:	f84a                	sd	s2,48(sp)
 b1e:	f44e                	sd	s3,40(sp)
 b20:	f052                	sd	s4,32(sp)
 b22:	ec56                	sd	s5,24(sp)
 b24:	e85a                	sd	s6,16(sp)
 b26:	e45e                	sd	s7,8(sp)
 b28:	e062                	sd	s8,0(sp)
 b2a:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 b2c:	0005c903          	lbu	s2,0(a1)
 b30:	18090c63          	beqz	s2,cc8 <vprintf+0x1b4>
 b34:	8aaa                	mv	s5,a0
 b36:	8bb2                	mv	s7,a2
 b38:	00158493          	addi	s1,a1,1
  state = 0;
 b3c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 b3e:	02500a13          	li	s4,37
 b42:	4b55                	li	s6,21
 b44:	a839                	j	b62 <vprintf+0x4e>
        putc(fd, c);
 b46:	85ca                	mv	a1,s2
 b48:	8556                	mv	a0,s5
 b4a:	00000097          	auipc	ra,0x0
 b4e:	efc080e7          	jalr	-260(ra) # a46 <putc>
 b52:	a019                	j	b58 <vprintf+0x44>
    } else if(state == '%'){
 b54:	01498d63          	beq	s3,s4,b6e <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 b58:	0485                	addi	s1,s1,1
 b5a:	fff4c903          	lbu	s2,-1(s1)
 b5e:	16090563          	beqz	s2,cc8 <vprintf+0x1b4>
    if(state == 0){
 b62:	fe0999e3          	bnez	s3,b54 <vprintf+0x40>
      if(c == '%'){
 b66:	ff4910e3          	bne	s2,s4,b46 <vprintf+0x32>
        state = '%';
 b6a:	89d2                	mv	s3,s4
 b6c:	b7f5                	j	b58 <vprintf+0x44>
      if(c == 'd'){
 b6e:	13490263          	beq	s2,s4,c92 <vprintf+0x17e>
 b72:	f9d9079b          	addiw	a5,s2,-99
 b76:	0ff7f793          	zext.b	a5,a5
 b7a:	12fb6563          	bltu	s6,a5,ca4 <vprintf+0x190>
 b7e:	f9d9079b          	addiw	a5,s2,-99
 b82:	0ff7f713          	zext.b	a4,a5
 b86:	10eb6f63          	bltu	s6,a4,ca4 <vprintf+0x190>
 b8a:	00271793          	slli	a5,a4,0x2
 b8e:	00000717          	auipc	a4,0x0
 b92:	4ba70713          	addi	a4,a4,1210 # 1048 <malloc+0x282>
 b96:	97ba                	add	a5,a5,a4
 b98:	439c                	lw	a5,0(a5)
 b9a:	97ba                	add	a5,a5,a4
 b9c:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 b9e:	008b8913          	addi	s2,s7,8
 ba2:	4685                	li	a3,1
 ba4:	4629                	li	a2,10
 ba6:	000ba583          	lw	a1,0(s7)
 baa:	8556                	mv	a0,s5
 bac:	00000097          	auipc	ra,0x0
 bb0:	ebc080e7          	jalr	-324(ra) # a68 <printint>
 bb4:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 bb6:	4981                	li	s3,0
 bb8:	b745                	j	b58 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 bba:	008b8913          	addi	s2,s7,8
 bbe:	4681                	li	a3,0
 bc0:	4629                	li	a2,10
 bc2:	000ba583          	lw	a1,0(s7)
 bc6:	8556                	mv	a0,s5
 bc8:	00000097          	auipc	ra,0x0
 bcc:	ea0080e7          	jalr	-352(ra) # a68 <printint>
 bd0:	8bca                	mv	s7,s2
      state = 0;
 bd2:	4981                	li	s3,0
 bd4:	b751                	j	b58 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 bd6:	008b8913          	addi	s2,s7,8
 bda:	4681                	li	a3,0
 bdc:	4641                	li	a2,16
 bde:	000ba583          	lw	a1,0(s7)
 be2:	8556                	mv	a0,s5
 be4:	00000097          	auipc	ra,0x0
 be8:	e84080e7          	jalr	-380(ra) # a68 <printint>
 bec:	8bca                	mv	s7,s2
      state = 0;
 bee:	4981                	li	s3,0
 bf0:	b7a5                	j	b58 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 bf2:	008b8c13          	addi	s8,s7,8
 bf6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 bfa:	03000593          	li	a1,48
 bfe:	8556                	mv	a0,s5
 c00:	00000097          	auipc	ra,0x0
 c04:	e46080e7          	jalr	-442(ra) # a46 <putc>
  putc(fd, 'x');
 c08:	07800593          	li	a1,120
 c0c:	8556                	mv	a0,s5
 c0e:	00000097          	auipc	ra,0x0
 c12:	e38080e7          	jalr	-456(ra) # a46 <putc>
 c16:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 c18:	00000b97          	auipc	s7,0x0
 c1c:	488b8b93          	addi	s7,s7,1160 # 10a0 <digits>
 c20:	03c9d793          	srli	a5,s3,0x3c
 c24:	97de                	add	a5,a5,s7
 c26:	0007c583          	lbu	a1,0(a5)
 c2a:	8556                	mv	a0,s5
 c2c:	00000097          	auipc	ra,0x0
 c30:	e1a080e7          	jalr	-486(ra) # a46 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 c34:	0992                	slli	s3,s3,0x4
 c36:	397d                	addiw	s2,s2,-1
 c38:	fe0914e3          	bnez	s2,c20 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 c3c:	8be2                	mv	s7,s8
      state = 0;
 c3e:	4981                	li	s3,0
 c40:	bf21                	j	b58 <vprintf+0x44>
        s = va_arg(ap, char*);
 c42:	008b8993          	addi	s3,s7,8
 c46:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 c4a:	02090163          	beqz	s2,c6c <vprintf+0x158>
        while(*s != 0){
 c4e:	00094583          	lbu	a1,0(s2)
 c52:	c9a5                	beqz	a1,cc2 <vprintf+0x1ae>
          putc(fd, *s);
 c54:	8556                	mv	a0,s5
 c56:	00000097          	auipc	ra,0x0
 c5a:	df0080e7          	jalr	-528(ra) # a46 <putc>
          s++;
 c5e:	0905                	addi	s2,s2,1
        while(*s != 0){
 c60:	00094583          	lbu	a1,0(s2)
 c64:	f9e5                	bnez	a1,c54 <vprintf+0x140>
        s = va_arg(ap, char*);
 c66:	8bce                	mv	s7,s3
      state = 0;
 c68:	4981                	li	s3,0
 c6a:	b5fd                	j	b58 <vprintf+0x44>
          s = "(null)";
 c6c:	00000917          	auipc	s2,0x0
 c70:	3d490913          	addi	s2,s2,980 # 1040 <malloc+0x27a>
        while(*s != 0){
 c74:	02800593          	li	a1,40
 c78:	bff1                	j	c54 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 c7a:	008b8913          	addi	s2,s7,8
 c7e:	000bc583          	lbu	a1,0(s7)
 c82:	8556                	mv	a0,s5
 c84:	00000097          	auipc	ra,0x0
 c88:	dc2080e7          	jalr	-574(ra) # a46 <putc>
 c8c:	8bca                	mv	s7,s2
      state = 0;
 c8e:	4981                	li	s3,0
 c90:	b5e1                	j	b58 <vprintf+0x44>
        putc(fd, c);
 c92:	02500593          	li	a1,37
 c96:	8556                	mv	a0,s5
 c98:	00000097          	auipc	ra,0x0
 c9c:	dae080e7          	jalr	-594(ra) # a46 <putc>
      state = 0;
 ca0:	4981                	li	s3,0
 ca2:	bd5d                	j	b58 <vprintf+0x44>
        putc(fd, '%');
 ca4:	02500593          	li	a1,37
 ca8:	8556                	mv	a0,s5
 caa:	00000097          	auipc	ra,0x0
 cae:	d9c080e7          	jalr	-612(ra) # a46 <putc>
        putc(fd, c);
 cb2:	85ca                	mv	a1,s2
 cb4:	8556                	mv	a0,s5
 cb6:	00000097          	auipc	ra,0x0
 cba:	d90080e7          	jalr	-624(ra) # a46 <putc>
      state = 0;
 cbe:	4981                	li	s3,0
 cc0:	bd61                	j	b58 <vprintf+0x44>
        s = va_arg(ap, char*);
 cc2:	8bce                	mv	s7,s3
      state = 0;
 cc4:	4981                	li	s3,0
 cc6:	bd49                	j	b58 <vprintf+0x44>
    }
  }
}
 cc8:	60a6                	ld	ra,72(sp)
 cca:	6406                	ld	s0,64(sp)
 ccc:	74e2                	ld	s1,56(sp)
 cce:	7942                	ld	s2,48(sp)
 cd0:	79a2                	ld	s3,40(sp)
 cd2:	7a02                	ld	s4,32(sp)
 cd4:	6ae2                	ld	s5,24(sp)
 cd6:	6b42                	ld	s6,16(sp)
 cd8:	6ba2                	ld	s7,8(sp)
 cda:	6c02                	ld	s8,0(sp)
 cdc:	6161                	addi	sp,sp,80
 cde:	8082                	ret

0000000000000ce0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ce0:	715d                	addi	sp,sp,-80
 ce2:	ec06                	sd	ra,24(sp)
 ce4:	e822                	sd	s0,16(sp)
 ce6:	1000                	addi	s0,sp,32
 ce8:	e010                	sd	a2,0(s0)
 cea:	e414                	sd	a3,8(s0)
 cec:	e818                	sd	a4,16(s0)
 cee:	ec1c                	sd	a5,24(s0)
 cf0:	03043023          	sd	a6,32(s0)
 cf4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 cf8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 cfc:	8622                	mv	a2,s0
 cfe:	00000097          	auipc	ra,0x0
 d02:	e16080e7          	jalr	-490(ra) # b14 <vprintf>
}
 d06:	60e2                	ld	ra,24(sp)
 d08:	6442                	ld	s0,16(sp)
 d0a:	6161                	addi	sp,sp,80
 d0c:	8082                	ret

0000000000000d0e <printf>:

void
printf(const char *fmt, ...)
{
 d0e:	711d                	addi	sp,sp,-96
 d10:	ec06                	sd	ra,24(sp)
 d12:	e822                	sd	s0,16(sp)
 d14:	1000                	addi	s0,sp,32
 d16:	e40c                	sd	a1,8(s0)
 d18:	e810                	sd	a2,16(s0)
 d1a:	ec14                	sd	a3,24(s0)
 d1c:	f018                	sd	a4,32(s0)
 d1e:	f41c                	sd	a5,40(s0)
 d20:	03043823          	sd	a6,48(s0)
 d24:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 d28:	00840613          	addi	a2,s0,8
 d2c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 d30:	85aa                	mv	a1,a0
 d32:	4505                	li	a0,1
 d34:	00000097          	auipc	ra,0x0
 d38:	de0080e7          	jalr	-544(ra) # b14 <vprintf>
}
 d3c:	60e2                	ld	ra,24(sp)
 d3e:	6442                	ld	s0,16(sp)
 d40:	6125                	addi	sp,sp,96
 d42:	8082                	ret

0000000000000d44 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 d44:	1141                	addi	sp,sp,-16
 d46:	e422                	sd	s0,8(sp)
 d48:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 d4a:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d4e:	00001797          	auipc	a5,0x1
 d52:	2ca7b783          	ld	a5,714(a5) # 2018 <freep>
 d56:	a02d                	j	d80 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 d58:	4618                	lw	a4,8(a2)
 d5a:	9f2d                	addw	a4,a4,a1
 d5c:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 d60:	6398                	ld	a4,0(a5)
 d62:	6310                	ld	a2,0(a4)
 d64:	a83d                	j	da2 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 d66:	ff852703          	lw	a4,-8(a0)
 d6a:	9f31                	addw	a4,a4,a2
 d6c:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 d6e:	ff053683          	ld	a3,-16(a0)
 d72:	a091                	j	db6 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d74:	6398                	ld	a4,0(a5)
 d76:	00e7e463          	bltu	a5,a4,d7e <free+0x3a>
 d7a:	00e6ea63          	bltu	a3,a4,d8e <free+0x4a>
{
 d7e:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d80:	fed7fae3          	bgeu	a5,a3,d74 <free+0x30>
 d84:	6398                	ld	a4,0(a5)
 d86:	00e6e463          	bltu	a3,a4,d8e <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d8a:	fee7eae3          	bltu	a5,a4,d7e <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 d8e:	ff852583          	lw	a1,-8(a0)
 d92:	6390                	ld	a2,0(a5)
 d94:	02059813          	slli	a6,a1,0x20
 d98:	01c85713          	srli	a4,a6,0x1c
 d9c:	9736                	add	a4,a4,a3
 d9e:	fae60de3          	beq	a2,a4,d58 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 da2:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 da6:	4790                	lw	a2,8(a5)
 da8:	02061593          	slli	a1,a2,0x20
 dac:	01c5d713          	srli	a4,a1,0x1c
 db0:	973e                	add	a4,a4,a5
 db2:	fae68ae3          	beq	a3,a4,d66 <free+0x22>
        p->s.ptr = bp->s.ptr;
 db6:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 db8:	00001717          	auipc	a4,0x1
 dbc:	26f73023          	sd	a5,608(a4) # 2018 <freep>
}
 dc0:	6422                	ld	s0,8(sp)
 dc2:	0141                	addi	sp,sp,16
 dc4:	8082                	ret

0000000000000dc6 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 dc6:	7139                	addi	sp,sp,-64
 dc8:	fc06                	sd	ra,56(sp)
 dca:	f822                	sd	s0,48(sp)
 dcc:	f426                	sd	s1,40(sp)
 dce:	f04a                	sd	s2,32(sp)
 dd0:	ec4e                	sd	s3,24(sp)
 dd2:	e852                	sd	s4,16(sp)
 dd4:	e456                	sd	s5,8(sp)
 dd6:	e05a                	sd	s6,0(sp)
 dd8:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 dda:	02051493          	slli	s1,a0,0x20
 dde:	9081                	srli	s1,s1,0x20
 de0:	04bd                	addi	s1,s1,15
 de2:	8091                	srli	s1,s1,0x4
 de4:	0014899b          	addiw	s3,s1,1
 de8:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 dea:	00001517          	auipc	a0,0x1
 dee:	22e53503          	ld	a0,558(a0) # 2018 <freep>
 df2:	c515                	beqz	a0,e1e <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 df4:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 df6:	4798                	lw	a4,8(a5)
 df8:	02977f63          	bgeu	a4,s1,e36 <malloc+0x70>
    if (nu < 4096)
 dfc:	8a4e                	mv	s4,s3
 dfe:	0009871b          	sext.w	a4,s3
 e02:	6685                	lui	a3,0x1
 e04:	00d77363          	bgeu	a4,a3,e0a <malloc+0x44>
 e08:	6a05                	lui	s4,0x1
 e0a:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 e0e:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 e12:	00001917          	auipc	s2,0x1
 e16:	20690913          	addi	s2,s2,518 # 2018 <freep>
    if (p == (char *)-1)
 e1a:	5afd                	li	s5,-1
 e1c:	a895                	j	e90 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 e1e:	00001797          	auipc	a5,0x1
 e22:	29278793          	addi	a5,a5,658 # 20b0 <base>
 e26:	00001717          	auipc	a4,0x1
 e2a:	1ef73923          	sd	a5,498(a4) # 2018 <freep>
 e2e:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 e30:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 e34:	b7e1                	j	dfc <malloc+0x36>
            if (p->s.size == nunits)
 e36:	02e48c63          	beq	s1,a4,e6e <malloc+0xa8>
                p->s.size -= nunits;
 e3a:	4137073b          	subw	a4,a4,s3
 e3e:	c798                	sw	a4,8(a5)
                p += p->s.size;
 e40:	02071693          	slli	a3,a4,0x20
 e44:	01c6d713          	srli	a4,a3,0x1c
 e48:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 e4a:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 e4e:	00001717          	auipc	a4,0x1
 e52:	1ca73523          	sd	a0,458(a4) # 2018 <freep>
            return (void *)(p + 1);
 e56:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 e5a:	70e2                	ld	ra,56(sp)
 e5c:	7442                	ld	s0,48(sp)
 e5e:	74a2                	ld	s1,40(sp)
 e60:	7902                	ld	s2,32(sp)
 e62:	69e2                	ld	s3,24(sp)
 e64:	6a42                	ld	s4,16(sp)
 e66:	6aa2                	ld	s5,8(sp)
 e68:	6b02                	ld	s6,0(sp)
 e6a:	6121                	addi	sp,sp,64
 e6c:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 e6e:	6398                	ld	a4,0(a5)
 e70:	e118                	sd	a4,0(a0)
 e72:	bff1                	j	e4e <malloc+0x88>
    hp->s.size = nu;
 e74:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 e78:	0541                	addi	a0,a0,16
 e7a:	00000097          	auipc	ra,0x0
 e7e:	eca080e7          	jalr	-310(ra) # d44 <free>
    return freep;
 e82:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 e86:	d971                	beqz	a0,e5a <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 e88:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 e8a:	4798                	lw	a4,8(a5)
 e8c:	fa9775e3          	bgeu	a4,s1,e36 <malloc+0x70>
        if (p == freep)
 e90:	00093703          	ld	a4,0(s2)
 e94:	853e                	mv	a0,a5
 e96:	fef719e3          	bne	a4,a5,e88 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 e9a:	8552                	mv	a0,s4
 e9c:	00000097          	auipc	ra,0x0
 ea0:	b7a080e7          	jalr	-1158(ra) # a16 <sbrk>
    if (p == (char *)-1)
 ea4:	fd5518e3          	bne	a0,s5,e74 <malloc+0xae>
                return 0;
 ea8:	4501                	li	a0,0
 eaa:	bf45                	j	e5a <malloc+0x94>
