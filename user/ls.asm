
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
  14:	6e4080e7          	jalr	1764(ra) # 6f4 <strlen>
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
  40:	6b8080e7          	jalr	1720(ra) # 6f4 <strlen>
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
  62:	696080e7          	jalr	1686(ra) # 6f4 <strlen>
  66:	00001997          	auipc	s3,0x1
  6a:	fba98993          	addi	s3,s3,-70 # 1020 <buf.0>
  6e:	0005061b          	sext.w	a2,a0
  72:	85a6                	mv	a1,s1
  74:	854e                	mv	a0,s3
  76:	00000097          	auipc	ra,0x0
  7a:	7f0080e7          	jalr	2032(ra) # 866 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  7e:	8526                	mv	a0,s1
  80:	00000097          	auipc	ra,0x0
  84:	674080e7          	jalr	1652(ra) # 6f4 <strlen>
  88:	0005091b          	sext.w	s2,a0
  8c:	8526                	mv	a0,s1
  8e:	00000097          	auipc	ra,0x0
  92:	666080e7          	jalr	1638(ra) # 6f4 <strlen>
  96:	1902                	slli	s2,s2,0x20
  98:	02095913          	srli	s2,s2,0x20
  9c:	4639                	li	a2,14
  9e:	9e09                	subw	a2,a2,a0
  a0:	02000593          	li	a1,32
  a4:	01298533          	add	a0,s3,s2
  a8:	00000097          	auipc	ra,0x0
  ac:	676080e7          	jalr	1654(ra) # 71e <memset>
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
  de:	87e080e7          	jalr	-1922(ra) # 958 <open>
  e2:	06054f63          	bltz	a0,160 <ls+0xac>
  e6:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  e8:	d9840593          	addi	a1,s0,-616
  ec:	00001097          	auipc	ra,0x1
  f0:	884080e7          	jalr	-1916(ra) # 970 <fstat>
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
 128:	d4c50513          	addi	a0,a0,-692 # e70 <malloc+0x120>
 12c:	00001097          	auipc	ra,0x1
 130:	b6c080e7          	jalr	-1172(ra) # c98 <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 134:	8526                	mv	a0,s1
 136:	00001097          	auipc	ra,0x1
 13a:	80a080e7          	jalr	-2038(ra) # 940 <close>
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
 166:	cde58593          	addi	a1,a1,-802 # e40 <malloc+0xf0>
 16a:	4509                	li	a0,2
 16c:	00001097          	auipc	ra,0x1
 170:	afe080e7          	jalr	-1282(ra) # c6a <fprintf>
    return;
 174:	b7e9                	j	13e <ls+0x8a>
    fprintf(2, "ls: cannot stat %s\n", path);
 176:	864a                	mv	a2,s2
 178:	00001597          	auipc	a1,0x1
 17c:	ce058593          	addi	a1,a1,-800 # e58 <malloc+0x108>
 180:	4509                	li	a0,2
 182:	00001097          	auipc	ra,0x1
 186:	ae8080e7          	jalr	-1304(ra) # c6a <fprintf>
    close(fd);
 18a:	8526                	mv	a0,s1
 18c:	00000097          	auipc	ra,0x0
 190:	7b4080e7          	jalr	1972(ra) # 940 <close>
    return;
 194:	b76d                	j	13e <ls+0x8a>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 196:	854a                	mv	a0,s2
 198:	00000097          	auipc	ra,0x0
 19c:	55c080e7          	jalr	1372(ra) # 6f4 <strlen>
 1a0:	2541                	addiw	a0,a0,16
 1a2:	20000793          	li	a5,512
 1a6:	00a7fb63          	bgeu	a5,a0,1bc <ls+0x108>
      printf("ls: path too long\n");
 1aa:	00001517          	auipc	a0,0x1
 1ae:	cd650513          	addi	a0,a0,-810 # e80 <malloc+0x130>
 1b2:	00001097          	auipc	ra,0x1
 1b6:	ae6080e7          	jalr	-1306(ra) # c98 <printf>
      break;
 1ba:	bfad                	j	134 <ls+0x80>
    strcpy(buf, path);
 1bc:	85ca                	mv	a1,s2
 1be:	dc040513          	addi	a0,s0,-576
 1c2:	00000097          	auipc	ra,0x0
 1c6:	4ea080e7          	jalr	1258(ra) # 6ac <strcpy>
    p = buf+strlen(buf);
 1ca:	dc040513          	addi	a0,s0,-576
 1ce:	00000097          	auipc	ra,0x0
 1d2:	526080e7          	jalr	1318(ra) # 6f4 <strlen>
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
 1f2:	caaa0a13          	addi	s4,s4,-854 # e98 <malloc+0x148>
        printf("ls: cannot stat %s\n", buf);
 1f6:	00001a97          	auipc	s5,0x1
 1fa:	c62a8a93          	addi	s5,s5,-926 # e58 <malloc+0x108>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1fe:	a801                	j	20e <ls+0x15a>
        printf("ls: cannot stat %s\n", buf);
 200:	dc040593          	addi	a1,s0,-576
 204:	8556                	mv	a0,s5
 206:	00001097          	auipc	ra,0x1
 20a:	a92080e7          	jalr	-1390(ra) # c98 <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 20e:	4641                	li	a2,16
 210:	db040593          	addi	a1,s0,-592
 214:	8526                	mv	a0,s1
 216:	00000097          	auipc	ra,0x0
 21a:	71a080e7          	jalr	1818(ra) # 930 <read>
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
 236:	634080e7          	jalr	1588(ra) # 866 <memmove>
      p[DIRSIZ] = 0;
 23a:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 23e:	d9840593          	addi	a1,s0,-616
 242:	dc040513          	addi	a0,s0,-576
 246:	00000097          	auipc	ra,0x0
 24a:	592080e7          	jalr	1426(ra) # 7d8 <stat>
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
 272:	a2a080e7          	jalr	-1494(ra) # c98 <printf>
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
 2b4:	668080e7          	jalr	1640(ra) # 918 <exit>
    ls(".");
 2b8:	00001517          	auipc	a0,0x1
 2bc:	bf050513          	addi	a0,a0,-1040 # ea8 <malloc+0x158>
 2c0:	00000097          	auipc	ra,0x0
 2c4:	df4080e7          	jalr	-524(ra) # b4 <ls>
    exit(0);
 2c8:	4501                	li	a0,0
 2ca:	00000097          	auipc	ra,0x0
 2ce:	64e080e7          	jalr	1614(ra) # 918 <exit>

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
 306:	2c4080e7          	jalr	708(ra) # 5c6 <twhoami>
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
 352:	b6250513          	addi	a0,a0,-1182 # eb0 <malloc+0x160>
 356:	00001097          	auipc	ra,0x1
 35a:	942080e7          	jalr	-1726(ra) # c98 <printf>
        exit(-1);
 35e:	557d                	li	a0,-1
 360:	00000097          	auipc	ra,0x0
 364:	5b8080e7          	jalr	1464(ra) # 918 <exit>
    {
        // give up the cpu for other threads
        tyield();
 368:	00000097          	auipc	ra,0x0
 36c:	1dc080e7          	jalr	476(ra) # 544 <tyield>
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
 386:	244080e7          	jalr	580(ra) # 5c6 <twhoami>
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
 3ca:	17e080e7          	jalr	382(ra) # 544 <tyield>
}
 3ce:	60e2                	ld	ra,24(sp)
 3d0:	6442                	ld	s0,16(sp)
 3d2:	64a2                	ld	s1,8(sp)
 3d4:	6105                	addi	sp,sp,32
 3d6:	8082                	ret
        printf("releasing lock we are not holding");
 3d8:	00001517          	auipc	a0,0x1
 3dc:	b0050513          	addi	a0,a0,-1280 # ed8 <malloc+0x188>
 3e0:	00001097          	auipc	ra,0x1
 3e4:	8b8080e7          	jalr	-1864(ra) # c98 <printf>
        exit(-1);
 3e8:	557d                	li	a0,-1
 3ea:	00000097          	auipc	ra,0x0
 3ee:	52e080e7          	jalr	1326(ra) # 918 <exit>

00000000000003f2 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 3f2:	00001517          	auipc	a0,0x1
 3f6:	c1e53503          	ld	a0,-994(a0) # 1010 <current_thread>
 3fa:	00001717          	auipc	a4,0x1
 3fe:	c3670713          	addi	a4,a4,-970 # 1030 <threads>
    for (int i = 0; i < 16; i++) {
 402:	4781                	li	a5,0
 404:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 406:	6314                	ld	a3,0(a4)
 408:	00a68763          	beq	a3,a0,416 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 40c:	2785                	addiw	a5,a5,1
 40e:	0721                	addi	a4,a4,8
 410:	fec79be3          	bne	a5,a2,406 <tsched+0x14>
    int current_index = 0;
 414:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 416:	0017869b          	addiw	a3,a5,1
 41a:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 41e:	00001817          	auipc	a6,0x1
 422:	c1280813          	addi	a6,a6,-1006 # 1030 <threads>
 426:	488d                	li	a7,3
 428:	a021                	j	430 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 42a:	2685                	addiw	a3,a3,1
 42c:	04c68363          	beq	a3,a2,472 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 430:	41f6d71b          	sraiw	a4,a3,0x1f
 434:	01c7571b          	srliw	a4,a4,0x1c
 438:	00d707bb          	addw	a5,a4,a3
 43c:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 43e:	9f99                	subw	a5,a5,a4
 440:	078e                	slli	a5,a5,0x3
 442:	97c2                	add	a5,a5,a6
 444:	638c                	ld	a1,0(a5)
 446:	d1f5                	beqz	a1,42a <tsched+0x38>
 448:	5dbc                	lw	a5,120(a1)
 44a:	ff1790e3          	bne	a5,a7,42a <tsched+0x38>
{
 44e:	1141                	addi	sp,sp,-16
 450:	e406                	sd	ra,8(sp)
 452:	e022                	sd	s0,0(sp)
 454:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 456:	00001797          	auipc	a5,0x1
 45a:	bab7bd23          	sd	a1,-1094(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 45e:	05a1                	addi	a1,a1,8
 460:	0521                	addi	a0,a0,8
 462:	00000097          	auipc	ra,0x0
 466:	17c080e7          	jalr	380(ra) # 5de <tswtch>
        //printf("Thread switch complete\n");
    }
}
 46a:	60a2                	ld	ra,8(sp)
 46c:	6402                	ld	s0,0(sp)
 46e:	0141                	addi	sp,sp,16
 470:	8082                	ret
 472:	8082                	ret

0000000000000474 <thread_wrapper>:
{
 474:	1101                	addi	sp,sp,-32
 476:	ec06                	sd	ra,24(sp)
 478:	e822                	sd	s0,16(sp)
 47a:	e426                	sd	s1,8(sp)
 47c:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
 47e:	00001497          	auipc	s1,0x1
 482:	b9248493          	addi	s1,s1,-1134 # 1010 <current_thread>
 486:	609c                	ld	a5,0(s1)
 488:	67d8                	ld	a4,136(a5)
 48a:	63c8                	ld	a0,128(a5)
 48c:	9702                	jalr	a4
    current_thread->state = EXITED;
 48e:	609c                	ld	a5,0(s1)
 490:	4719                	li	a4,6
 492:	dfb8                	sw	a4,120(a5)
    tsched();
 494:	00000097          	auipc	ra,0x0
 498:	f5e080e7          	jalr	-162(ra) # 3f2 <tsched>
}
 49c:	60e2                	ld	ra,24(sp)
 49e:	6442                	ld	s0,16(sp)
 4a0:	64a2                	ld	s1,8(sp)
 4a2:	6105                	addi	sp,sp,32
 4a4:	8082                	ret

00000000000004a6 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 4a6:	7179                	addi	sp,sp,-48
 4a8:	f406                	sd	ra,40(sp)
 4aa:	f022                	sd	s0,32(sp)
 4ac:	ec26                	sd	s1,24(sp)
 4ae:	e84a                	sd	s2,16(sp)
 4b0:	e44e                	sd	s3,8(sp)
 4b2:	1800                	addi	s0,sp,48
 4b4:	84aa                	mv	s1,a0
 4b6:	89b2                	mv	s3,a2
 4b8:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 4ba:	09800513          	li	a0,152
 4be:	00001097          	auipc	ra,0x1
 4c2:	892080e7          	jalr	-1902(ra) # d50 <malloc>
 4c6:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 4c8:	478d                	li	a5,3
 4ca:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 4cc:	609c                	ld	a5,0(s1)
 4ce:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 4d2:	609c                	ld	a5,0(s1)
 4d4:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
 4d8:	6098                	ld	a4,0(s1)
 4da:	00001797          	auipc	a5,0x1
 4de:	b2678793          	addi	a5,a5,-1242 # 1000 <next_tid>
 4e2:	4394                	lw	a3,0(a5)
 4e4:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 4e8:	4398                	lw	a4,0(a5)
 4ea:	2705                	addiw	a4,a4,1
 4ec:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
 4ee:	6505                	lui	a0,0x1
 4f0:	00001097          	auipc	ra,0x1
 4f4:	860080e7          	jalr	-1952(ra) # d50 <malloc>
 4f8:	609c                	ld	a5,0(s1)
 4fa:	6705                	lui	a4,0x1
 4fc:	953a                	add	a0,a0,a4
 4fe:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 500:	609c                	ld	a5,0(s1)
 502:	00000717          	auipc	a4,0x0
 506:	f7270713          	addi	a4,a4,-142 # 474 <thread_wrapper>
 50a:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 50c:	00001717          	auipc	a4,0x1
 510:	b2470713          	addi	a4,a4,-1244 # 1030 <threads>
 514:	4781                	li	a5,0
 516:	4641                	li	a2,16
        if (threads[i] == NULL) {
 518:	6314                	ld	a3,0(a4)
 51a:	ce81                	beqz	a3,532 <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
 51c:	2785                	addiw	a5,a5,1
 51e:	0721                	addi	a4,a4,8
 520:	fec79ce3          	bne	a5,a2,518 <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
 524:	70a2                	ld	ra,40(sp)
 526:	7402                	ld	s0,32(sp)
 528:	64e2                	ld	s1,24(sp)
 52a:	6942                	ld	s2,16(sp)
 52c:	69a2                	ld	s3,8(sp)
 52e:	6145                	addi	sp,sp,48
 530:	8082                	ret
            threads[i] = *thread;
 532:	6094                	ld	a3,0(s1)
 534:	078e                	slli	a5,a5,0x3
 536:	00001717          	auipc	a4,0x1
 53a:	afa70713          	addi	a4,a4,-1286 # 1030 <threads>
 53e:	97ba                	add	a5,a5,a4
 540:	e394                	sd	a3,0(a5)
            break;
 542:	b7cd                	j	524 <tcreate+0x7e>

0000000000000544 <tyield>:
    return 0;
}


void tyield()
{
 544:	1141                	addi	sp,sp,-16
 546:	e406                	sd	ra,8(sp)
 548:	e022                	sd	s0,0(sp)
 54a:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 54c:	00001797          	auipc	a5,0x1
 550:	ac47b783          	ld	a5,-1340(a5) # 1010 <current_thread>
 554:	470d                	li	a4,3
 556:	dfb8                	sw	a4,120(a5)
    tsched();
 558:	00000097          	auipc	ra,0x0
 55c:	e9a080e7          	jalr	-358(ra) # 3f2 <tsched>
}
 560:	60a2                	ld	ra,8(sp)
 562:	6402                	ld	s0,0(sp)
 564:	0141                	addi	sp,sp,16
 566:	8082                	ret

0000000000000568 <tjoin>:
{
 568:	1101                	addi	sp,sp,-32
 56a:	ec06                	sd	ra,24(sp)
 56c:	e822                	sd	s0,16(sp)
 56e:	e426                	sd	s1,8(sp)
 570:	e04a                	sd	s2,0(sp)
 572:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 574:	00001797          	auipc	a5,0x1
 578:	abc78793          	addi	a5,a5,-1348 # 1030 <threads>
 57c:	00001697          	auipc	a3,0x1
 580:	b3468693          	addi	a3,a3,-1228 # 10b0 <base>
 584:	a021                	j	58c <tjoin+0x24>
 586:	07a1                	addi	a5,a5,8
 588:	02d78b63          	beq	a5,a3,5be <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 58c:	6384                	ld	s1,0(a5)
 58e:	dce5                	beqz	s1,586 <tjoin+0x1e>
 590:	0004c703          	lbu	a4,0(s1)
 594:	fea719e3          	bne	a4,a0,586 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 598:	5cb8                	lw	a4,120(s1)
 59a:	4799                	li	a5,6
 59c:	4919                	li	s2,6
 59e:	02f70263          	beq	a4,a5,5c2 <tjoin+0x5a>
        tyield();
 5a2:	00000097          	auipc	ra,0x0
 5a6:	fa2080e7          	jalr	-94(ra) # 544 <tyield>
    while (target_thread->state != EXITED) {
 5aa:	5cbc                	lw	a5,120(s1)
 5ac:	ff279be3          	bne	a5,s2,5a2 <tjoin+0x3a>
    return 0;
 5b0:	4501                	li	a0,0
}
 5b2:	60e2                	ld	ra,24(sp)
 5b4:	6442                	ld	s0,16(sp)
 5b6:	64a2                	ld	s1,8(sp)
 5b8:	6902                	ld	s2,0(sp)
 5ba:	6105                	addi	sp,sp,32
 5bc:	8082                	ret
        return -1;
 5be:	557d                	li	a0,-1
 5c0:	bfcd                	j	5b2 <tjoin+0x4a>
    return 0;
 5c2:	4501                	li	a0,0
 5c4:	b7fd                	j	5b2 <tjoin+0x4a>

00000000000005c6 <twhoami>:

uint8 twhoami()
{
 5c6:	1141                	addi	sp,sp,-16
 5c8:	e422                	sd	s0,8(sp)
 5ca:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 5cc:	00001797          	auipc	a5,0x1
 5d0:	a447b783          	ld	a5,-1468(a5) # 1010 <current_thread>
 5d4:	0007c503          	lbu	a0,0(a5)
 5d8:	6422                	ld	s0,8(sp)
 5da:	0141                	addi	sp,sp,16
 5dc:	8082                	ret

00000000000005de <tswtch>:
 5de:	00153023          	sd	ra,0(a0) # 1000 <next_tid>
 5e2:	00253423          	sd	sp,8(a0)
 5e6:	e900                	sd	s0,16(a0)
 5e8:	ed04                	sd	s1,24(a0)
 5ea:	03253023          	sd	s2,32(a0)
 5ee:	03353423          	sd	s3,40(a0)
 5f2:	03453823          	sd	s4,48(a0)
 5f6:	03553c23          	sd	s5,56(a0)
 5fa:	05653023          	sd	s6,64(a0)
 5fe:	05753423          	sd	s7,72(a0)
 602:	05853823          	sd	s8,80(a0)
 606:	05953c23          	sd	s9,88(a0)
 60a:	07a53023          	sd	s10,96(a0)
 60e:	07b53423          	sd	s11,104(a0)
 612:	0005b083          	ld	ra,0(a1)
 616:	0085b103          	ld	sp,8(a1)
 61a:	6980                	ld	s0,16(a1)
 61c:	6d84                	ld	s1,24(a1)
 61e:	0205b903          	ld	s2,32(a1)
 622:	0285b983          	ld	s3,40(a1)
 626:	0305ba03          	ld	s4,48(a1)
 62a:	0385ba83          	ld	s5,56(a1)
 62e:	0405bb03          	ld	s6,64(a1)
 632:	0485bb83          	ld	s7,72(a1)
 636:	0505bc03          	ld	s8,80(a1)
 63a:	0585bc83          	ld	s9,88(a1)
 63e:	0605bd03          	ld	s10,96(a1)
 642:	0685bd83          	ld	s11,104(a1)
 646:	8082                	ret

0000000000000648 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 648:	1101                	addi	sp,sp,-32
 64a:	ec06                	sd	ra,24(sp)
 64c:	e822                	sd	s0,16(sp)
 64e:	e426                	sd	s1,8(sp)
 650:	e04a                	sd	s2,0(sp)
 652:	1000                	addi	s0,sp,32
 654:	84aa                	mv	s1,a0
 656:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 658:	09800513          	li	a0,152
 65c:	00000097          	auipc	ra,0x0
 660:	6f4080e7          	jalr	1780(ra) # d50 <malloc>

    main_thread->tid = 1;
 664:	4785                	li	a5,1
 666:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
 66a:	4791                	li	a5,4
 66c:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 66e:	00001797          	auipc	a5,0x1
 672:	9aa7b123          	sd	a0,-1630(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 676:	00001797          	auipc	a5,0x1
 67a:	9ba78793          	addi	a5,a5,-1606 # 1030 <threads>
 67e:	00001717          	auipc	a4,0x1
 682:	a3270713          	addi	a4,a4,-1486 # 10b0 <base>
        threads[i] = NULL;
 686:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 68a:	07a1                	addi	a5,a5,8
 68c:	fee79de3          	bne	a5,a4,686 <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 690:	00001797          	auipc	a5,0x1
 694:	9aa7b023          	sd	a0,-1632(a5) # 1030 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 698:	85ca                	mv	a1,s2
 69a:	8526                	mv	a0,s1
 69c:	00000097          	auipc	ra,0x0
 6a0:	bdc080e7          	jalr	-1060(ra) # 278 <main>
    //tsched();

    exit(res);
 6a4:	00000097          	auipc	ra,0x0
 6a8:	274080e7          	jalr	628(ra) # 918 <exit>

00000000000006ac <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 6ac:	1141                	addi	sp,sp,-16
 6ae:	e422                	sd	s0,8(sp)
 6b0:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 6b2:	87aa                	mv	a5,a0
 6b4:	0585                	addi	a1,a1,1
 6b6:	0785                	addi	a5,a5,1
 6b8:	fff5c703          	lbu	a4,-1(a1)
 6bc:	fee78fa3          	sb	a4,-1(a5)
 6c0:	fb75                	bnez	a4,6b4 <strcpy+0x8>
        ;
    return os;
}
 6c2:	6422                	ld	s0,8(sp)
 6c4:	0141                	addi	sp,sp,16
 6c6:	8082                	ret

00000000000006c8 <strcmp>:

int strcmp(const char *p, const char *q)
{
 6c8:	1141                	addi	sp,sp,-16
 6ca:	e422                	sd	s0,8(sp)
 6cc:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 6ce:	00054783          	lbu	a5,0(a0)
 6d2:	cb91                	beqz	a5,6e6 <strcmp+0x1e>
 6d4:	0005c703          	lbu	a4,0(a1)
 6d8:	00f71763          	bne	a4,a5,6e6 <strcmp+0x1e>
        p++, q++;
 6dc:	0505                	addi	a0,a0,1
 6de:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 6e0:	00054783          	lbu	a5,0(a0)
 6e4:	fbe5                	bnez	a5,6d4 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 6e6:	0005c503          	lbu	a0,0(a1)
}
 6ea:	40a7853b          	subw	a0,a5,a0
 6ee:	6422                	ld	s0,8(sp)
 6f0:	0141                	addi	sp,sp,16
 6f2:	8082                	ret

00000000000006f4 <strlen>:

uint strlen(const char *s)
{
 6f4:	1141                	addi	sp,sp,-16
 6f6:	e422                	sd	s0,8(sp)
 6f8:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 6fa:	00054783          	lbu	a5,0(a0)
 6fe:	cf91                	beqz	a5,71a <strlen+0x26>
 700:	0505                	addi	a0,a0,1
 702:	87aa                	mv	a5,a0
 704:	86be                	mv	a3,a5
 706:	0785                	addi	a5,a5,1
 708:	fff7c703          	lbu	a4,-1(a5)
 70c:	ff65                	bnez	a4,704 <strlen+0x10>
 70e:	40a6853b          	subw	a0,a3,a0
 712:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 714:	6422                	ld	s0,8(sp)
 716:	0141                	addi	sp,sp,16
 718:	8082                	ret
    for (n = 0; s[n]; n++)
 71a:	4501                	li	a0,0
 71c:	bfe5                	j	714 <strlen+0x20>

000000000000071e <memset>:

void *
memset(void *dst, int c, uint n)
{
 71e:	1141                	addi	sp,sp,-16
 720:	e422                	sd	s0,8(sp)
 722:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 724:	ca19                	beqz	a2,73a <memset+0x1c>
 726:	87aa                	mv	a5,a0
 728:	1602                	slli	a2,a2,0x20
 72a:	9201                	srli	a2,a2,0x20
 72c:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 730:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 734:	0785                	addi	a5,a5,1
 736:	fee79de3          	bne	a5,a4,730 <memset+0x12>
    }
    return dst;
}
 73a:	6422                	ld	s0,8(sp)
 73c:	0141                	addi	sp,sp,16
 73e:	8082                	ret

0000000000000740 <strchr>:

char *
strchr(const char *s, char c)
{
 740:	1141                	addi	sp,sp,-16
 742:	e422                	sd	s0,8(sp)
 744:	0800                	addi	s0,sp,16
    for (; *s; s++)
 746:	00054783          	lbu	a5,0(a0)
 74a:	cb99                	beqz	a5,760 <strchr+0x20>
        if (*s == c)
 74c:	00f58763          	beq	a1,a5,75a <strchr+0x1a>
    for (; *s; s++)
 750:	0505                	addi	a0,a0,1
 752:	00054783          	lbu	a5,0(a0)
 756:	fbfd                	bnez	a5,74c <strchr+0xc>
            return (char *)s;
    return 0;
 758:	4501                	li	a0,0
}
 75a:	6422                	ld	s0,8(sp)
 75c:	0141                	addi	sp,sp,16
 75e:	8082                	ret
    return 0;
 760:	4501                	li	a0,0
 762:	bfe5                	j	75a <strchr+0x1a>

0000000000000764 <gets>:

char *
gets(char *buf, int max)
{
 764:	711d                	addi	sp,sp,-96
 766:	ec86                	sd	ra,88(sp)
 768:	e8a2                	sd	s0,80(sp)
 76a:	e4a6                	sd	s1,72(sp)
 76c:	e0ca                	sd	s2,64(sp)
 76e:	fc4e                	sd	s3,56(sp)
 770:	f852                	sd	s4,48(sp)
 772:	f456                	sd	s5,40(sp)
 774:	f05a                	sd	s6,32(sp)
 776:	ec5e                	sd	s7,24(sp)
 778:	1080                	addi	s0,sp,96
 77a:	8baa                	mv	s7,a0
 77c:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 77e:	892a                	mv	s2,a0
 780:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 782:	4aa9                	li	s5,10
 784:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 786:	89a6                	mv	s3,s1
 788:	2485                	addiw	s1,s1,1
 78a:	0344d863          	bge	s1,s4,7ba <gets+0x56>
        cc = read(0, &c, 1);
 78e:	4605                	li	a2,1
 790:	faf40593          	addi	a1,s0,-81
 794:	4501                	li	a0,0
 796:	00000097          	auipc	ra,0x0
 79a:	19a080e7          	jalr	410(ra) # 930 <read>
        if (cc < 1)
 79e:	00a05e63          	blez	a0,7ba <gets+0x56>
        buf[i++] = c;
 7a2:	faf44783          	lbu	a5,-81(s0)
 7a6:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 7aa:	01578763          	beq	a5,s5,7b8 <gets+0x54>
 7ae:	0905                	addi	s2,s2,1
 7b0:	fd679be3          	bne	a5,s6,786 <gets+0x22>
    for (i = 0; i + 1 < max;)
 7b4:	89a6                	mv	s3,s1
 7b6:	a011                	j	7ba <gets+0x56>
 7b8:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 7ba:	99de                	add	s3,s3,s7
 7bc:	00098023          	sb	zero,0(s3)
    return buf;
}
 7c0:	855e                	mv	a0,s7
 7c2:	60e6                	ld	ra,88(sp)
 7c4:	6446                	ld	s0,80(sp)
 7c6:	64a6                	ld	s1,72(sp)
 7c8:	6906                	ld	s2,64(sp)
 7ca:	79e2                	ld	s3,56(sp)
 7cc:	7a42                	ld	s4,48(sp)
 7ce:	7aa2                	ld	s5,40(sp)
 7d0:	7b02                	ld	s6,32(sp)
 7d2:	6be2                	ld	s7,24(sp)
 7d4:	6125                	addi	sp,sp,96
 7d6:	8082                	ret

00000000000007d8 <stat>:

int stat(const char *n, struct stat *st)
{
 7d8:	1101                	addi	sp,sp,-32
 7da:	ec06                	sd	ra,24(sp)
 7dc:	e822                	sd	s0,16(sp)
 7de:	e426                	sd	s1,8(sp)
 7e0:	e04a                	sd	s2,0(sp)
 7e2:	1000                	addi	s0,sp,32
 7e4:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 7e6:	4581                	li	a1,0
 7e8:	00000097          	auipc	ra,0x0
 7ec:	170080e7          	jalr	368(ra) # 958 <open>
    if (fd < 0)
 7f0:	02054563          	bltz	a0,81a <stat+0x42>
 7f4:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 7f6:	85ca                	mv	a1,s2
 7f8:	00000097          	auipc	ra,0x0
 7fc:	178080e7          	jalr	376(ra) # 970 <fstat>
 800:	892a                	mv	s2,a0
    close(fd);
 802:	8526                	mv	a0,s1
 804:	00000097          	auipc	ra,0x0
 808:	13c080e7          	jalr	316(ra) # 940 <close>
    return r;
}
 80c:	854a                	mv	a0,s2
 80e:	60e2                	ld	ra,24(sp)
 810:	6442                	ld	s0,16(sp)
 812:	64a2                	ld	s1,8(sp)
 814:	6902                	ld	s2,0(sp)
 816:	6105                	addi	sp,sp,32
 818:	8082                	ret
        return -1;
 81a:	597d                	li	s2,-1
 81c:	bfc5                	j	80c <stat+0x34>

000000000000081e <atoi>:

int atoi(const char *s)
{
 81e:	1141                	addi	sp,sp,-16
 820:	e422                	sd	s0,8(sp)
 822:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 824:	00054683          	lbu	a3,0(a0)
 828:	fd06879b          	addiw	a5,a3,-48
 82c:	0ff7f793          	zext.b	a5,a5
 830:	4625                	li	a2,9
 832:	02f66863          	bltu	a2,a5,862 <atoi+0x44>
 836:	872a                	mv	a4,a0
    n = 0;
 838:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 83a:	0705                	addi	a4,a4,1
 83c:	0025179b          	slliw	a5,a0,0x2
 840:	9fa9                	addw	a5,a5,a0
 842:	0017979b          	slliw	a5,a5,0x1
 846:	9fb5                	addw	a5,a5,a3
 848:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 84c:	00074683          	lbu	a3,0(a4)
 850:	fd06879b          	addiw	a5,a3,-48
 854:	0ff7f793          	zext.b	a5,a5
 858:	fef671e3          	bgeu	a2,a5,83a <atoi+0x1c>
    return n;
}
 85c:	6422                	ld	s0,8(sp)
 85e:	0141                	addi	sp,sp,16
 860:	8082                	ret
    n = 0;
 862:	4501                	li	a0,0
 864:	bfe5                	j	85c <atoi+0x3e>

0000000000000866 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 866:	1141                	addi	sp,sp,-16
 868:	e422                	sd	s0,8(sp)
 86a:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 86c:	02b57463          	bgeu	a0,a1,894 <memmove+0x2e>
    {
        while (n-- > 0)
 870:	00c05f63          	blez	a2,88e <memmove+0x28>
 874:	1602                	slli	a2,a2,0x20
 876:	9201                	srli	a2,a2,0x20
 878:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 87c:	872a                	mv	a4,a0
            *dst++ = *src++;
 87e:	0585                	addi	a1,a1,1
 880:	0705                	addi	a4,a4,1
 882:	fff5c683          	lbu	a3,-1(a1)
 886:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 88a:	fee79ae3          	bne	a5,a4,87e <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 88e:	6422                	ld	s0,8(sp)
 890:	0141                	addi	sp,sp,16
 892:	8082                	ret
        dst += n;
 894:	00c50733          	add	a4,a0,a2
        src += n;
 898:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 89a:	fec05ae3          	blez	a2,88e <memmove+0x28>
 89e:	fff6079b          	addiw	a5,a2,-1
 8a2:	1782                	slli	a5,a5,0x20
 8a4:	9381                	srli	a5,a5,0x20
 8a6:	fff7c793          	not	a5,a5
 8aa:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 8ac:	15fd                	addi	a1,a1,-1
 8ae:	177d                	addi	a4,a4,-1
 8b0:	0005c683          	lbu	a3,0(a1)
 8b4:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 8b8:	fee79ae3          	bne	a5,a4,8ac <memmove+0x46>
 8bc:	bfc9                	j	88e <memmove+0x28>

00000000000008be <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 8be:	1141                	addi	sp,sp,-16
 8c0:	e422                	sd	s0,8(sp)
 8c2:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 8c4:	ca05                	beqz	a2,8f4 <memcmp+0x36>
 8c6:	fff6069b          	addiw	a3,a2,-1
 8ca:	1682                	slli	a3,a3,0x20
 8cc:	9281                	srli	a3,a3,0x20
 8ce:	0685                	addi	a3,a3,1
 8d0:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 8d2:	00054783          	lbu	a5,0(a0)
 8d6:	0005c703          	lbu	a4,0(a1)
 8da:	00e79863          	bne	a5,a4,8ea <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 8de:	0505                	addi	a0,a0,1
        p2++;
 8e0:	0585                	addi	a1,a1,1
    while (n-- > 0)
 8e2:	fed518e3          	bne	a0,a3,8d2 <memcmp+0x14>
    }
    return 0;
 8e6:	4501                	li	a0,0
 8e8:	a019                	j	8ee <memcmp+0x30>
            return *p1 - *p2;
 8ea:	40e7853b          	subw	a0,a5,a4
}
 8ee:	6422                	ld	s0,8(sp)
 8f0:	0141                	addi	sp,sp,16
 8f2:	8082                	ret
    return 0;
 8f4:	4501                	li	a0,0
 8f6:	bfe5                	j	8ee <memcmp+0x30>

00000000000008f8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 8f8:	1141                	addi	sp,sp,-16
 8fa:	e406                	sd	ra,8(sp)
 8fc:	e022                	sd	s0,0(sp)
 8fe:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 900:	00000097          	auipc	ra,0x0
 904:	f66080e7          	jalr	-154(ra) # 866 <memmove>
}
 908:	60a2                	ld	ra,8(sp)
 90a:	6402                	ld	s0,0(sp)
 90c:	0141                	addi	sp,sp,16
 90e:	8082                	ret

0000000000000910 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 910:	4885                	li	a7,1
 ecall
 912:	00000073          	ecall
 ret
 916:	8082                	ret

0000000000000918 <exit>:
.global exit
exit:
 li a7, SYS_exit
 918:	4889                	li	a7,2
 ecall
 91a:	00000073          	ecall
 ret
 91e:	8082                	ret

0000000000000920 <wait>:
.global wait
wait:
 li a7, SYS_wait
 920:	488d                	li	a7,3
 ecall
 922:	00000073          	ecall
 ret
 926:	8082                	ret

0000000000000928 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 928:	4891                	li	a7,4
 ecall
 92a:	00000073          	ecall
 ret
 92e:	8082                	ret

0000000000000930 <read>:
.global read
read:
 li a7, SYS_read
 930:	4895                	li	a7,5
 ecall
 932:	00000073          	ecall
 ret
 936:	8082                	ret

0000000000000938 <write>:
.global write
write:
 li a7, SYS_write
 938:	48c1                	li	a7,16
 ecall
 93a:	00000073          	ecall
 ret
 93e:	8082                	ret

0000000000000940 <close>:
.global close
close:
 li a7, SYS_close
 940:	48d5                	li	a7,21
 ecall
 942:	00000073          	ecall
 ret
 946:	8082                	ret

0000000000000948 <kill>:
.global kill
kill:
 li a7, SYS_kill
 948:	4899                	li	a7,6
 ecall
 94a:	00000073          	ecall
 ret
 94e:	8082                	ret

0000000000000950 <exec>:
.global exec
exec:
 li a7, SYS_exec
 950:	489d                	li	a7,7
 ecall
 952:	00000073          	ecall
 ret
 956:	8082                	ret

0000000000000958 <open>:
.global open
open:
 li a7, SYS_open
 958:	48bd                	li	a7,15
 ecall
 95a:	00000073          	ecall
 ret
 95e:	8082                	ret

0000000000000960 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 960:	48c5                	li	a7,17
 ecall
 962:	00000073          	ecall
 ret
 966:	8082                	ret

0000000000000968 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 968:	48c9                	li	a7,18
 ecall
 96a:	00000073          	ecall
 ret
 96e:	8082                	ret

0000000000000970 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 970:	48a1                	li	a7,8
 ecall
 972:	00000073          	ecall
 ret
 976:	8082                	ret

0000000000000978 <link>:
.global link
link:
 li a7, SYS_link
 978:	48cd                	li	a7,19
 ecall
 97a:	00000073          	ecall
 ret
 97e:	8082                	ret

0000000000000980 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 980:	48d1                	li	a7,20
 ecall
 982:	00000073          	ecall
 ret
 986:	8082                	ret

0000000000000988 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 988:	48a5                	li	a7,9
 ecall
 98a:	00000073          	ecall
 ret
 98e:	8082                	ret

0000000000000990 <dup>:
.global dup
dup:
 li a7, SYS_dup
 990:	48a9                	li	a7,10
 ecall
 992:	00000073          	ecall
 ret
 996:	8082                	ret

0000000000000998 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 998:	48ad                	li	a7,11
 ecall
 99a:	00000073          	ecall
 ret
 99e:	8082                	ret

00000000000009a0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 9a0:	48b1                	li	a7,12
 ecall
 9a2:	00000073          	ecall
 ret
 9a6:	8082                	ret

00000000000009a8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 9a8:	48b5                	li	a7,13
 ecall
 9aa:	00000073          	ecall
 ret
 9ae:	8082                	ret

00000000000009b0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 9b0:	48b9                	li	a7,14
 ecall
 9b2:	00000073          	ecall
 ret
 9b6:	8082                	ret

00000000000009b8 <ps>:
.global ps
ps:
 li a7, SYS_ps
 9b8:	48d9                	li	a7,22
 ecall
 9ba:	00000073          	ecall
 ret
 9be:	8082                	ret

00000000000009c0 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 9c0:	48dd                	li	a7,23
 ecall
 9c2:	00000073          	ecall
 ret
 9c6:	8082                	ret

00000000000009c8 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 9c8:	48e1                	li	a7,24
 ecall
 9ca:	00000073          	ecall
 ret
 9ce:	8082                	ret

00000000000009d0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 9d0:	1101                	addi	sp,sp,-32
 9d2:	ec06                	sd	ra,24(sp)
 9d4:	e822                	sd	s0,16(sp)
 9d6:	1000                	addi	s0,sp,32
 9d8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 9dc:	4605                	li	a2,1
 9de:	fef40593          	addi	a1,s0,-17
 9e2:	00000097          	auipc	ra,0x0
 9e6:	f56080e7          	jalr	-170(ra) # 938 <write>
}
 9ea:	60e2                	ld	ra,24(sp)
 9ec:	6442                	ld	s0,16(sp)
 9ee:	6105                	addi	sp,sp,32
 9f0:	8082                	ret

00000000000009f2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 9f2:	7139                	addi	sp,sp,-64
 9f4:	fc06                	sd	ra,56(sp)
 9f6:	f822                	sd	s0,48(sp)
 9f8:	f426                	sd	s1,40(sp)
 9fa:	f04a                	sd	s2,32(sp)
 9fc:	ec4e                	sd	s3,24(sp)
 9fe:	0080                	addi	s0,sp,64
 a00:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 a02:	c299                	beqz	a3,a08 <printint+0x16>
 a04:	0805c963          	bltz	a1,a96 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 a08:	2581                	sext.w	a1,a1
  neg = 0;
 a0a:	4881                	li	a7,0
 a0c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 a10:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 a12:	2601                	sext.w	a2,a2
 a14:	00000517          	auipc	a0,0x0
 a18:	54c50513          	addi	a0,a0,1356 # f60 <digits>
 a1c:	883a                	mv	a6,a4
 a1e:	2705                	addiw	a4,a4,1
 a20:	02c5f7bb          	remuw	a5,a1,a2
 a24:	1782                	slli	a5,a5,0x20
 a26:	9381                	srli	a5,a5,0x20
 a28:	97aa                	add	a5,a5,a0
 a2a:	0007c783          	lbu	a5,0(a5)
 a2e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 a32:	0005879b          	sext.w	a5,a1
 a36:	02c5d5bb          	divuw	a1,a1,a2
 a3a:	0685                	addi	a3,a3,1
 a3c:	fec7f0e3          	bgeu	a5,a2,a1c <printint+0x2a>
  if(neg)
 a40:	00088c63          	beqz	a7,a58 <printint+0x66>
    buf[i++] = '-';
 a44:	fd070793          	addi	a5,a4,-48
 a48:	00878733          	add	a4,a5,s0
 a4c:	02d00793          	li	a5,45
 a50:	fef70823          	sb	a5,-16(a4)
 a54:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 a58:	02e05863          	blez	a4,a88 <printint+0x96>
 a5c:	fc040793          	addi	a5,s0,-64
 a60:	00e78933          	add	s2,a5,a4
 a64:	fff78993          	addi	s3,a5,-1
 a68:	99ba                	add	s3,s3,a4
 a6a:	377d                	addiw	a4,a4,-1
 a6c:	1702                	slli	a4,a4,0x20
 a6e:	9301                	srli	a4,a4,0x20
 a70:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 a74:	fff94583          	lbu	a1,-1(s2)
 a78:	8526                	mv	a0,s1
 a7a:	00000097          	auipc	ra,0x0
 a7e:	f56080e7          	jalr	-170(ra) # 9d0 <putc>
  while(--i >= 0)
 a82:	197d                	addi	s2,s2,-1
 a84:	ff3918e3          	bne	s2,s3,a74 <printint+0x82>
}
 a88:	70e2                	ld	ra,56(sp)
 a8a:	7442                	ld	s0,48(sp)
 a8c:	74a2                	ld	s1,40(sp)
 a8e:	7902                	ld	s2,32(sp)
 a90:	69e2                	ld	s3,24(sp)
 a92:	6121                	addi	sp,sp,64
 a94:	8082                	ret
    x = -xx;
 a96:	40b005bb          	negw	a1,a1
    neg = 1;
 a9a:	4885                	li	a7,1
    x = -xx;
 a9c:	bf85                	j	a0c <printint+0x1a>

0000000000000a9e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 a9e:	715d                	addi	sp,sp,-80
 aa0:	e486                	sd	ra,72(sp)
 aa2:	e0a2                	sd	s0,64(sp)
 aa4:	fc26                	sd	s1,56(sp)
 aa6:	f84a                	sd	s2,48(sp)
 aa8:	f44e                	sd	s3,40(sp)
 aaa:	f052                	sd	s4,32(sp)
 aac:	ec56                	sd	s5,24(sp)
 aae:	e85a                	sd	s6,16(sp)
 ab0:	e45e                	sd	s7,8(sp)
 ab2:	e062                	sd	s8,0(sp)
 ab4:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 ab6:	0005c903          	lbu	s2,0(a1)
 aba:	18090c63          	beqz	s2,c52 <vprintf+0x1b4>
 abe:	8aaa                	mv	s5,a0
 ac0:	8bb2                	mv	s7,a2
 ac2:	00158493          	addi	s1,a1,1
  state = 0;
 ac6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 ac8:	02500a13          	li	s4,37
 acc:	4b55                	li	s6,21
 ace:	a839                	j	aec <vprintf+0x4e>
        putc(fd, c);
 ad0:	85ca                	mv	a1,s2
 ad2:	8556                	mv	a0,s5
 ad4:	00000097          	auipc	ra,0x0
 ad8:	efc080e7          	jalr	-260(ra) # 9d0 <putc>
 adc:	a019                	j	ae2 <vprintf+0x44>
    } else if(state == '%'){
 ade:	01498d63          	beq	s3,s4,af8 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 ae2:	0485                	addi	s1,s1,1
 ae4:	fff4c903          	lbu	s2,-1(s1)
 ae8:	16090563          	beqz	s2,c52 <vprintf+0x1b4>
    if(state == 0){
 aec:	fe0999e3          	bnez	s3,ade <vprintf+0x40>
      if(c == '%'){
 af0:	ff4910e3          	bne	s2,s4,ad0 <vprintf+0x32>
        state = '%';
 af4:	89d2                	mv	s3,s4
 af6:	b7f5                	j	ae2 <vprintf+0x44>
      if(c == 'd'){
 af8:	13490263          	beq	s2,s4,c1c <vprintf+0x17e>
 afc:	f9d9079b          	addiw	a5,s2,-99
 b00:	0ff7f793          	zext.b	a5,a5
 b04:	12fb6563          	bltu	s6,a5,c2e <vprintf+0x190>
 b08:	f9d9079b          	addiw	a5,s2,-99
 b0c:	0ff7f713          	zext.b	a4,a5
 b10:	10eb6f63          	bltu	s6,a4,c2e <vprintf+0x190>
 b14:	00271793          	slli	a5,a4,0x2
 b18:	00000717          	auipc	a4,0x0
 b1c:	3f070713          	addi	a4,a4,1008 # f08 <malloc+0x1b8>
 b20:	97ba                	add	a5,a5,a4
 b22:	439c                	lw	a5,0(a5)
 b24:	97ba                	add	a5,a5,a4
 b26:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 b28:	008b8913          	addi	s2,s7,8
 b2c:	4685                	li	a3,1
 b2e:	4629                	li	a2,10
 b30:	000ba583          	lw	a1,0(s7)
 b34:	8556                	mv	a0,s5
 b36:	00000097          	auipc	ra,0x0
 b3a:	ebc080e7          	jalr	-324(ra) # 9f2 <printint>
 b3e:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 b40:	4981                	li	s3,0
 b42:	b745                	j	ae2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 b44:	008b8913          	addi	s2,s7,8
 b48:	4681                	li	a3,0
 b4a:	4629                	li	a2,10
 b4c:	000ba583          	lw	a1,0(s7)
 b50:	8556                	mv	a0,s5
 b52:	00000097          	auipc	ra,0x0
 b56:	ea0080e7          	jalr	-352(ra) # 9f2 <printint>
 b5a:	8bca                	mv	s7,s2
      state = 0;
 b5c:	4981                	li	s3,0
 b5e:	b751                	j	ae2 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 b60:	008b8913          	addi	s2,s7,8
 b64:	4681                	li	a3,0
 b66:	4641                	li	a2,16
 b68:	000ba583          	lw	a1,0(s7)
 b6c:	8556                	mv	a0,s5
 b6e:	00000097          	auipc	ra,0x0
 b72:	e84080e7          	jalr	-380(ra) # 9f2 <printint>
 b76:	8bca                	mv	s7,s2
      state = 0;
 b78:	4981                	li	s3,0
 b7a:	b7a5                	j	ae2 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 b7c:	008b8c13          	addi	s8,s7,8
 b80:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 b84:	03000593          	li	a1,48
 b88:	8556                	mv	a0,s5
 b8a:	00000097          	auipc	ra,0x0
 b8e:	e46080e7          	jalr	-442(ra) # 9d0 <putc>
  putc(fd, 'x');
 b92:	07800593          	li	a1,120
 b96:	8556                	mv	a0,s5
 b98:	00000097          	auipc	ra,0x0
 b9c:	e38080e7          	jalr	-456(ra) # 9d0 <putc>
 ba0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 ba2:	00000b97          	auipc	s7,0x0
 ba6:	3beb8b93          	addi	s7,s7,958 # f60 <digits>
 baa:	03c9d793          	srli	a5,s3,0x3c
 bae:	97de                	add	a5,a5,s7
 bb0:	0007c583          	lbu	a1,0(a5)
 bb4:	8556                	mv	a0,s5
 bb6:	00000097          	auipc	ra,0x0
 bba:	e1a080e7          	jalr	-486(ra) # 9d0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 bbe:	0992                	slli	s3,s3,0x4
 bc0:	397d                	addiw	s2,s2,-1
 bc2:	fe0914e3          	bnez	s2,baa <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 bc6:	8be2                	mv	s7,s8
      state = 0;
 bc8:	4981                	li	s3,0
 bca:	bf21                	j	ae2 <vprintf+0x44>
        s = va_arg(ap, char*);
 bcc:	008b8993          	addi	s3,s7,8
 bd0:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 bd4:	02090163          	beqz	s2,bf6 <vprintf+0x158>
        while(*s != 0){
 bd8:	00094583          	lbu	a1,0(s2)
 bdc:	c9a5                	beqz	a1,c4c <vprintf+0x1ae>
          putc(fd, *s);
 bde:	8556                	mv	a0,s5
 be0:	00000097          	auipc	ra,0x0
 be4:	df0080e7          	jalr	-528(ra) # 9d0 <putc>
          s++;
 be8:	0905                	addi	s2,s2,1
        while(*s != 0){
 bea:	00094583          	lbu	a1,0(s2)
 bee:	f9e5                	bnez	a1,bde <vprintf+0x140>
        s = va_arg(ap, char*);
 bf0:	8bce                	mv	s7,s3
      state = 0;
 bf2:	4981                	li	s3,0
 bf4:	b5fd                	j	ae2 <vprintf+0x44>
          s = "(null)";
 bf6:	00000917          	auipc	s2,0x0
 bfa:	30a90913          	addi	s2,s2,778 # f00 <malloc+0x1b0>
        while(*s != 0){
 bfe:	02800593          	li	a1,40
 c02:	bff1                	j	bde <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 c04:	008b8913          	addi	s2,s7,8
 c08:	000bc583          	lbu	a1,0(s7)
 c0c:	8556                	mv	a0,s5
 c0e:	00000097          	auipc	ra,0x0
 c12:	dc2080e7          	jalr	-574(ra) # 9d0 <putc>
 c16:	8bca                	mv	s7,s2
      state = 0;
 c18:	4981                	li	s3,0
 c1a:	b5e1                	j	ae2 <vprintf+0x44>
        putc(fd, c);
 c1c:	02500593          	li	a1,37
 c20:	8556                	mv	a0,s5
 c22:	00000097          	auipc	ra,0x0
 c26:	dae080e7          	jalr	-594(ra) # 9d0 <putc>
      state = 0;
 c2a:	4981                	li	s3,0
 c2c:	bd5d                	j	ae2 <vprintf+0x44>
        putc(fd, '%');
 c2e:	02500593          	li	a1,37
 c32:	8556                	mv	a0,s5
 c34:	00000097          	auipc	ra,0x0
 c38:	d9c080e7          	jalr	-612(ra) # 9d0 <putc>
        putc(fd, c);
 c3c:	85ca                	mv	a1,s2
 c3e:	8556                	mv	a0,s5
 c40:	00000097          	auipc	ra,0x0
 c44:	d90080e7          	jalr	-624(ra) # 9d0 <putc>
      state = 0;
 c48:	4981                	li	s3,0
 c4a:	bd61                	j	ae2 <vprintf+0x44>
        s = va_arg(ap, char*);
 c4c:	8bce                	mv	s7,s3
      state = 0;
 c4e:	4981                	li	s3,0
 c50:	bd49                	j	ae2 <vprintf+0x44>
    }
  }
}
 c52:	60a6                	ld	ra,72(sp)
 c54:	6406                	ld	s0,64(sp)
 c56:	74e2                	ld	s1,56(sp)
 c58:	7942                	ld	s2,48(sp)
 c5a:	79a2                	ld	s3,40(sp)
 c5c:	7a02                	ld	s4,32(sp)
 c5e:	6ae2                	ld	s5,24(sp)
 c60:	6b42                	ld	s6,16(sp)
 c62:	6ba2                	ld	s7,8(sp)
 c64:	6c02                	ld	s8,0(sp)
 c66:	6161                	addi	sp,sp,80
 c68:	8082                	ret

0000000000000c6a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 c6a:	715d                	addi	sp,sp,-80
 c6c:	ec06                	sd	ra,24(sp)
 c6e:	e822                	sd	s0,16(sp)
 c70:	1000                	addi	s0,sp,32
 c72:	e010                	sd	a2,0(s0)
 c74:	e414                	sd	a3,8(s0)
 c76:	e818                	sd	a4,16(s0)
 c78:	ec1c                	sd	a5,24(s0)
 c7a:	03043023          	sd	a6,32(s0)
 c7e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 c82:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 c86:	8622                	mv	a2,s0
 c88:	00000097          	auipc	ra,0x0
 c8c:	e16080e7          	jalr	-490(ra) # a9e <vprintf>
}
 c90:	60e2                	ld	ra,24(sp)
 c92:	6442                	ld	s0,16(sp)
 c94:	6161                	addi	sp,sp,80
 c96:	8082                	ret

0000000000000c98 <printf>:

void
printf(const char *fmt, ...)
{
 c98:	711d                	addi	sp,sp,-96
 c9a:	ec06                	sd	ra,24(sp)
 c9c:	e822                	sd	s0,16(sp)
 c9e:	1000                	addi	s0,sp,32
 ca0:	e40c                	sd	a1,8(s0)
 ca2:	e810                	sd	a2,16(s0)
 ca4:	ec14                	sd	a3,24(s0)
 ca6:	f018                	sd	a4,32(s0)
 ca8:	f41c                	sd	a5,40(s0)
 caa:	03043823          	sd	a6,48(s0)
 cae:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 cb2:	00840613          	addi	a2,s0,8
 cb6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 cba:	85aa                	mv	a1,a0
 cbc:	4505                	li	a0,1
 cbe:	00000097          	auipc	ra,0x0
 cc2:	de0080e7          	jalr	-544(ra) # a9e <vprintf>
}
 cc6:	60e2                	ld	ra,24(sp)
 cc8:	6442                	ld	s0,16(sp)
 cca:	6125                	addi	sp,sp,96
 ccc:	8082                	ret

0000000000000cce <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 cce:	1141                	addi	sp,sp,-16
 cd0:	e422                	sd	s0,8(sp)
 cd2:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 cd4:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cd8:	00000797          	auipc	a5,0x0
 cdc:	3407b783          	ld	a5,832(a5) # 1018 <freep>
 ce0:	a02d                	j	d0a <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 ce2:	4618                	lw	a4,8(a2)
 ce4:	9f2d                	addw	a4,a4,a1
 ce6:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 cea:	6398                	ld	a4,0(a5)
 cec:	6310                	ld	a2,0(a4)
 cee:	a83d                	j	d2c <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 cf0:	ff852703          	lw	a4,-8(a0)
 cf4:	9f31                	addw	a4,a4,a2
 cf6:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 cf8:	ff053683          	ld	a3,-16(a0)
 cfc:	a091                	j	d40 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 cfe:	6398                	ld	a4,0(a5)
 d00:	00e7e463          	bltu	a5,a4,d08 <free+0x3a>
 d04:	00e6ea63          	bltu	a3,a4,d18 <free+0x4a>
{
 d08:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d0a:	fed7fae3          	bgeu	a5,a3,cfe <free+0x30>
 d0e:	6398                	ld	a4,0(a5)
 d10:	00e6e463          	bltu	a3,a4,d18 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d14:	fee7eae3          	bltu	a5,a4,d08 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 d18:	ff852583          	lw	a1,-8(a0)
 d1c:	6390                	ld	a2,0(a5)
 d1e:	02059813          	slli	a6,a1,0x20
 d22:	01c85713          	srli	a4,a6,0x1c
 d26:	9736                	add	a4,a4,a3
 d28:	fae60de3          	beq	a2,a4,ce2 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 d2c:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 d30:	4790                	lw	a2,8(a5)
 d32:	02061593          	slli	a1,a2,0x20
 d36:	01c5d713          	srli	a4,a1,0x1c
 d3a:	973e                	add	a4,a4,a5
 d3c:	fae68ae3          	beq	a3,a4,cf0 <free+0x22>
        p->s.ptr = bp->s.ptr;
 d40:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 d42:	00000717          	auipc	a4,0x0
 d46:	2cf73b23          	sd	a5,726(a4) # 1018 <freep>
}
 d4a:	6422                	ld	s0,8(sp)
 d4c:	0141                	addi	sp,sp,16
 d4e:	8082                	ret

0000000000000d50 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 d50:	7139                	addi	sp,sp,-64
 d52:	fc06                	sd	ra,56(sp)
 d54:	f822                	sd	s0,48(sp)
 d56:	f426                	sd	s1,40(sp)
 d58:	f04a                	sd	s2,32(sp)
 d5a:	ec4e                	sd	s3,24(sp)
 d5c:	e852                	sd	s4,16(sp)
 d5e:	e456                	sd	s5,8(sp)
 d60:	e05a                	sd	s6,0(sp)
 d62:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 d64:	02051493          	slli	s1,a0,0x20
 d68:	9081                	srli	s1,s1,0x20
 d6a:	04bd                	addi	s1,s1,15
 d6c:	8091                	srli	s1,s1,0x4
 d6e:	0014899b          	addiw	s3,s1,1
 d72:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 d74:	00000517          	auipc	a0,0x0
 d78:	2a453503          	ld	a0,676(a0) # 1018 <freep>
 d7c:	c515                	beqz	a0,da8 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 d7e:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 d80:	4798                	lw	a4,8(a5)
 d82:	02977f63          	bgeu	a4,s1,dc0 <malloc+0x70>
    if (nu < 4096)
 d86:	8a4e                	mv	s4,s3
 d88:	0009871b          	sext.w	a4,s3
 d8c:	6685                	lui	a3,0x1
 d8e:	00d77363          	bgeu	a4,a3,d94 <malloc+0x44>
 d92:	6a05                	lui	s4,0x1
 d94:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 d98:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 d9c:	00000917          	auipc	s2,0x0
 da0:	27c90913          	addi	s2,s2,636 # 1018 <freep>
    if (p == (char *)-1)
 da4:	5afd                	li	s5,-1
 da6:	a895                	j	e1a <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 da8:	00000797          	auipc	a5,0x0
 dac:	30878793          	addi	a5,a5,776 # 10b0 <base>
 db0:	00000717          	auipc	a4,0x0
 db4:	26f73423          	sd	a5,616(a4) # 1018 <freep>
 db8:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 dba:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 dbe:	b7e1                	j	d86 <malloc+0x36>
            if (p->s.size == nunits)
 dc0:	02e48c63          	beq	s1,a4,df8 <malloc+0xa8>
                p->s.size -= nunits;
 dc4:	4137073b          	subw	a4,a4,s3
 dc8:	c798                	sw	a4,8(a5)
                p += p->s.size;
 dca:	02071693          	slli	a3,a4,0x20
 dce:	01c6d713          	srli	a4,a3,0x1c
 dd2:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 dd4:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 dd8:	00000717          	auipc	a4,0x0
 ddc:	24a73023          	sd	a0,576(a4) # 1018 <freep>
            return (void *)(p + 1);
 de0:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 de4:	70e2                	ld	ra,56(sp)
 de6:	7442                	ld	s0,48(sp)
 de8:	74a2                	ld	s1,40(sp)
 dea:	7902                	ld	s2,32(sp)
 dec:	69e2                	ld	s3,24(sp)
 dee:	6a42                	ld	s4,16(sp)
 df0:	6aa2                	ld	s5,8(sp)
 df2:	6b02                	ld	s6,0(sp)
 df4:	6121                	addi	sp,sp,64
 df6:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 df8:	6398                	ld	a4,0(a5)
 dfa:	e118                	sd	a4,0(a0)
 dfc:	bff1                	j	dd8 <malloc+0x88>
    hp->s.size = nu;
 dfe:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 e02:	0541                	addi	a0,a0,16
 e04:	00000097          	auipc	ra,0x0
 e08:	eca080e7          	jalr	-310(ra) # cce <free>
    return freep;
 e0c:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 e10:	d971                	beqz	a0,de4 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 e12:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 e14:	4798                	lw	a4,8(a5)
 e16:	fa9775e3          	bgeu	a4,s1,dc0 <malloc+0x70>
        if (p == freep)
 e1a:	00093703          	ld	a4,0(s2)
 e1e:	853e                	mv	a0,a5
 e20:	fef719e3          	bne	a4,a5,e12 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 e24:	8552                	mv	a0,s4
 e26:	00000097          	auipc	ra,0x0
 e2a:	b7a080e7          	jalr	-1158(ra) # 9a0 <sbrk>
    if (p == (char *)-1)
 e2e:	fd5518e3          	bne	a0,s5,dfe <malloc+0xae>
                return 0;
 e32:	4501                	li	a0,0
 e34:	bf45                	j	de4 <malloc+0x94>
