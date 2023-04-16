
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	addi	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	addi	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4901                	li	s2,0
  l = w = c = 0;
  28:	4d01                	li	s10,0
  2a:	4c81                	li	s9,0
  2c:	4c01                	li	s8,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  2e:	00001d97          	auipc	s11,0x1
  32:	ff2d8d93          	addi	s11,s11,-14 # 1020 <buf>
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  36:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  38:	00001a17          	auipc	s4,0x1
  3c:	d38a0a13          	addi	s4,s4,-712 # d70 <malloc+0xf2>
        inword = 0;
  40:	4b81                	li	s7,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  42:	a805                	j	72 <wc+0x72>
      if(strchr(" \r\t\n\v", buf[i]))
  44:	8552                	mv	a0,s4
  46:	00000097          	auipc	ra,0x0
  4a:	628080e7          	jalr	1576(ra) # 66e <strchr>
  4e:	c919                	beqz	a0,64 <wc+0x64>
        inword = 0;
  50:	895e                	mv	s2,s7
    for(i=0; i<n; i++){
  52:	0485                	addi	s1,s1,1
  54:	00998d63          	beq	s3,s1,6e <wc+0x6e>
      if(buf[i] == '\n')
  58:	0004c583          	lbu	a1,0(s1)
  5c:	ff5594e3          	bne	a1,s5,44 <wc+0x44>
        l++;
  60:	2c05                	addiw	s8,s8,1
  62:	b7cd                	j	44 <wc+0x44>
      else if(!inword){
  64:	fe0917e3          	bnez	s2,52 <wc+0x52>
        w++;
  68:	2c85                	addiw	s9,s9,1
        inword = 1;
  6a:	4905                	li	s2,1
  6c:	b7dd                	j	52 <wc+0x52>
      c++;
  6e:	01ab0d3b          	addw	s10,s6,s10
  while((n = read(fd, buf, sizeof(buf))) > 0){
  72:	20000613          	li	a2,512
  76:	85ee                	mv	a1,s11
  78:	f8843503          	ld	a0,-120(s0)
  7c:	00000097          	auipc	ra,0x0
  80:	7e2080e7          	jalr	2018(ra) # 85e <read>
  84:	8b2a                	mv	s6,a0
  86:	00a05963          	blez	a0,98 <wc+0x98>
    for(i=0; i<n; i++){
  8a:	00001497          	auipc	s1,0x1
  8e:	f9648493          	addi	s1,s1,-106 # 1020 <buf>
  92:	009509b3          	add	s3,a0,s1
  96:	b7c9                	j	58 <wc+0x58>
      }
    }
  }
  if(n < 0){
  98:	02054e63          	bltz	a0,d4 <wc+0xd4>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  9c:	f8043703          	ld	a4,-128(s0)
  a0:	86ea                	mv	a3,s10
  a2:	8666                	mv	a2,s9
  a4:	85e2                	mv	a1,s8
  a6:	00001517          	auipc	a0,0x1
  aa:	ce250513          	addi	a0,a0,-798 # d88 <malloc+0x10a>
  ae:	00001097          	auipc	ra,0x1
  b2:	b18080e7          	jalr	-1256(ra) # bc6 <printf>
}
  b6:	70e6                	ld	ra,120(sp)
  b8:	7446                	ld	s0,112(sp)
  ba:	74a6                	ld	s1,104(sp)
  bc:	7906                	ld	s2,96(sp)
  be:	69e6                	ld	s3,88(sp)
  c0:	6a46                	ld	s4,80(sp)
  c2:	6aa6                	ld	s5,72(sp)
  c4:	6b06                	ld	s6,64(sp)
  c6:	7be2                	ld	s7,56(sp)
  c8:	7c42                	ld	s8,48(sp)
  ca:	7ca2                	ld	s9,40(sp)
  cc:	7d02                	ld	s10,32(sp)
  ce:	6de2                	ld	s11,24(sp)
  d0:	6109                	addi	sp,sp,128
  d2:	8082                	ret
    printf("wc: read error\n");
  d4:	00001517          	auipc	a0,0x1
  d8:	ca450513          	addi	a0,a0,-860 # d78 <malloc+0xfa>
  dc:	00001097          	auipc	ra,0x1
  e0:	aea080e7          	jalr	-1302(ra) # bc6 <printf>
    exit(1);
  e4:	4505                	li	a0,1
  e6:	00000097          	auipc	ra,0x0
  ea:	760080e7          	jalr	1888(ra) # 846 <exit>

00000000000000ee <main>:

int
main(int argc, char *argv[])
{
  ee:	7179                	addi	sp,sp,-48
  f0:	f406                	sd	ra,40(sp)
  f2:	f022                	sd	s0,32(sp)
  f4:	ec26                	sd	s1,24(sp)
  f6:	e84a                	sd	s2,16(sp)
  f8:	e44e                	sd	s3,8(sp)
  fa:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  fc:	4785                	li	a5,1
  fe:	04a7d963          	bge	a5,a0,150 <main+0x62>
 102:	00858913          	addi	s2,a1,8
 106:	ffe5099b          	addiw	s3,a0,-2
 10a:	02099793          	slli	a5,s3,0x20
 10e:	01d7d993          	srli	s3,a5,0x1d
 112:	05c1                	addi	a1,a1,16
 114:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
 116:	4581                	li	a1,0
 118:	00093503          	ld	a0,0(s2)
 11c:	00000097          	auipc	ra,0x0
 120:	76a080e7          	jalr	1898(ra) # 886 <open>
 124:	84aa                	mv	s1,a0
 126:	04054363          	bltz	a0,16c <main+0x7e>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 12a:	00093583          	ld	a1,0(s2)
 12e:	00000097          	auipc	ra,0x0
 132:	ed2080e7          	jalr	-302(ra) # 0 <wc>
    close(fd);
 136:	8526                	mv	a0,s1
 138:	00000097          	auipc	ra,0x0
 13c:	736080e7          	jalr	1846(ra) # 86e <close>
  for(i = 1; i < argc; i++){
 140:	0921                	addi	s2,s2,8
 142:	fd391ae3          	bne	s2,s3,116 <main+0x28>
  }
  exit(0);
 146:	4501                	li	a0,0
 148:	00000097          	auipc	ra,0x0
 14c:	6fe080e7          	jalr	1790(ra) # 846 <exit>
    wc(0, "");
 150:	00001597          	auipc	a1,0x1
 154:	d5858593          	addi	a1,a1,-680 # ea8 <malloc+0x22a>
 158:	4501                	li	a0,0
 15a:	00000097          	auipc	ra,0x0
 15e:	ea6080e7          	jalr	-346(ra) # 0 <wc>
    exit(0);
 162:	4501                	li	a0,0
 164:	00000097          	auipc	ra,0x0
 168:	6e2080e7          	jalr	1762(ra) # 846 <exit>
      printf("wc: cannot open %s\n", argv[i]);
 16c:	00093583          	ld	a1,0(s2)
 170:	00001517          	auipc	a0,0x1
 174:	c2850513          	addi	a0,a0,-984 # d98 <malloc+0x11a>
 178:	00001097          	auipc	ra,0x1
 17c:	a4e080e7          	jalr	-1458(ra) # bc6 <printf>
      exit(1);
 180:	4505                	li	a0,1
 182:	00000097          	auipc	ra,0x0
 186:	6c4080e7          	jalr	1732(ra) # 846 <exit>

000000000000018a <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
 18a:	1141                	addi	sp,sp,-16
 18c:	e422                	sd	s0,8(sp)
 18e:	0800                	addi	s0,sp,16
    lk->name = name;
 190:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
 192:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
 196:	57fd                	li	a5,-1
 198:	00f50823          	sb	a5,16(a0)
}
 19c:	6422                	ld	s0,8(sp)
 19e:	0141                	addi	sp,sp,16
 1a0:	8082                	ret

00000000000001a2 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
 1a2:	00054783          	lbu	a5,0(a0)
 1a6:	e399                	bnez	a5,1ac <holding+0xa>
 1a8:	4501                	li	a0,0
}
 1aa:	8082                	ret
{
 1ac:	1101                	addi	sp,sp,-32
 1ae:	ec06                	sd	ra,24(sp)
 1b0:	e822                	sd	s0,16(sp)
 1b2:	e426                	sd	s1,8(sp)
 1b4:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
 1b6:	01054483          	lbu	s1,16(a0)
 1ba:	00000097          	auipc	ra,0x0
 1be:	2dc080e7          	jalr	732(ra) # 496 <twhoami>
 1c2:	2501                	sext.w	a0,a0
 1c4:	40a48533          	sub	a0,s1,a0
 1c8:	00153513          	seqz	a0,a0
}
 1cc:	60e2                	ld	ra,24(sp)
 1ce:	6442                	ld	s0,16(sp)
 1d0:	64a2                	ld	s1,8(sp)
 1d2:	6105                	addi	sp,sp,32
 1d4:	8082                	ret

00000000000001d6 <acquire>:

void acquire(struct lock *lk)
{
 1d6:	7179                	addi	sp,sp,-48
 1d8:	f406                	sd	ra,40(sp)
 1da:	f022                	sd	s0,32(sp)
 1dc:	ec26                	sd	s1,24(sp)
 1de:	e84a                	sd	s2,16(sp)
 1e0:	e44e                	sd	s3,8(sp)
 1e2:	e052                	sd	s4,0(sp)
 1e4:	1800                	addi	s0,sp,48
 1e6:	8a2a                	mv	s4,a0
    if (holding(lk))
 1e8:	00000097          	auipc	ra,0x0
 1ec:	fba080e7          	jalr	-70(ra) # 1a2 <holding>
 1f0:	e919                	bnez	a0,206 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 1f2:	ffca7493          	andi	s1,s4,-4
 1f6:	003a7913          	andi	s2,s4,3
 1fa:	0039191b          	slliw	s2,s2,0x3
 1fe:	4985                	li	s3,1
 200:	012999bb          	sllw	s3,s3,s2
 204:	a015                	j	228 <acquire+0x52>
        printf("re-acquiring lock we already hold");
 206:	00001517          	auipc	a0,0x1
 20a:	baa50513          	addi	a0,a0,-1110 # db0 <malloc+0x132>
 20e:	00001097          	auipc	ra,0x1
 212:	9b8080e7          	jalr	-1608(ra) # bc6 <printf>
        exit(-1);
 216:	557d                	li	a0,-1
 218:	00000097          	auipc	ra,0x0
 21c:	62e080e7          	jalr	1582(ra) # 846 <exit>
    {
        // give up the cpu for other threads
        tyield();
 220:	00000097          	auipc	ra,0x0
 224:	252080e7          	jalr	594(ra) # 472 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 228:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 22c:	0127d7bb          	srlw	a5,a5,s2
 230:	0ff7f793          	zext.b	a5,a5
 234:	f7f5                	bnez	a5,220 <acquire+0x4a>
    }

    __sync_synchronize();
 236:	0ff0000f          	fence

    lk->tid = twhoami();
 23a:	00000097          	auipc	ra,0x0
 23e:	25c080e7          	jalr	604(ra) # 496 <twhoami>
 242:	00aa0823          	sb	a0,16(s4)
}
 246:	70a2                	ld	ra,40(sp)
 248:	7402                	ld	s0,32(sp)
 24a:	64e2                	ld	s1,24(sp)
 24c:	6942                	ld	s2,16(sp)
 24e:	69a2                	ld	s3,8(sp)
 250:	6a02                	ld	s4,0(sp)
 252:	6145                	addi	sp,sp,48
 254:	8082                	ret

0000000000000256 <release>:

void release(struct lock *lk)
{
 256:	1101                	addi	sp,sp,-32
 258:	ec06                	sd	ra,24(sp)
 25a:	e822                	sd	s0,16(sp)
 25c:	e426                	sd	s1,8(sp)
 25e:	1000                	addi	s0,sp,32
 260:	84aa                	mv	s1,a0
    if (!holding(lk))
 262:	00000097          	auipc	ra,0x0
 266:	f40080e7          	jalr	-192(ra) # 1a2 <holding>
 26a:	c11d                	beqz	a0,290 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 26c:	57fd                	li	a5,-1
 26e:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 272:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 276:	0ff0000f          	fence
 27a:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 27e:	00000097          	auipc	ra,0x0
 282:	1f4080e7          	jalr	500(ra) # 472 <tyield>
}
 286:	60e2                	ld	ra,24(sp)
 288:	6442                	ld	s0,16(sp)
 28a:	64a2                	ld	s1,8(sp)
 28c:	6105                	addi	sp,sp,32
 28e:	8082                	ret
        printf("releasing lock we are not holding");
 290:	00001517          	auipc	a0,0x1
 294:	b4850513          	addi	a0,a0,-1208 # dd8 <malloc+0x15a>
 298:	00001097          	auipc	ra,0x1
 29c:	92e080e7          	jalr	-1746(ra) # bc6 <printf>
        exit(-1);
 2a0:	557d                	li	a0,-1
 2a2:	00000097          	auipc	ra,0x0
 2a6:	5a4080e7          	jalr	1444(ra) # 846 <exit>

00000000000002aa <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
 2aa:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 2ac:	00001617          	auipc	a2,0x1
 2b0:	f7460613          	addi	a2,a2,-140 # 1220 <threads>
 2b4:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
 2b6:	45c1                	li	a1,16
 2b8:	a021                	j	2c0 <tsched+0x16>
 2ba:	2685                	addiw	a3,a3,1
 2bc:	08b68c63          	beq	a3,a1,354 <tsched+0xaa>
        int next_index = (current_index + i) % 16;
 2c0:	41f6d71b          	sraiw	a4,a3,0x1f
 2c4:	01c7571b          	srliw	a4,a4,0x1c
 2c8:	00d707bb          	addw	a5,a4,a3
 2cc:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 2ce:	9f99                	subw	a5,a5,a4
 2d0:	078e                	slli	a5,a5,0x3
 2d2:	97b2                	add	a5,a5,a2
 2d4:	639c                	ld	a5,0(a5)
 2d6:	d3f5                	beqz	a5,2ba <tsched+0x10>
 2d8:	5fb8                	lw	a4,120(a5)
 2da:	fea710e3          	bne	a4,a0,2ba <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
 2de:	00001717          	auipc	a4,0x1
 2e2:	f4273703          	ld	a4,-190(a4) # 1220 <threads>
 2e6:	5f30                	lw	a2,120(a4)
 2e8:	468d                	li	a3,3
 2ea:	06d60363          	beq	a2,a3,350 <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
 2ee:	c3a5                	beqz	a5,34e <tsched+0xa4>
{
 2f0:	1101                	addi	sp,sp,-32
 2f2:	ec06                	sd	ra,24(sp)
 2f4:	e822                	sd	s0,16(sp)
 2f6:	e426                	sd	s1,8(sp)
 2f8:	e04a                	sd	s2,0(sp)
 2fa:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
 2fc:	00001497          	auipc	s1,0x1
 300:	d1448493          	addi	s1,s1,-748 # 1010 <current_thread>
 304:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
 308:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
 30a:	0007c603          	lbu	a2,0(a5)
 30e:	00094583          	lbu	a1,0(s2)
 312:	00001517          	auipc	a0,0x1
 316:	aee50513          	addi	a0,a0,-1298 # e00 <malloc+0x182>
 31a:	00001097          	auipc	ra,0x1
 31e:	8ac080e7          	jalr	-1876(ra) # bc6 <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 322:	608c                	ld	a1,0(s1)
 324:	05a1                	addi	a1,a1,8
 326:	00890513          	addi	a0,s2,8
 32a:	00000097          	auipc	ra,0x0
 32e:	184080e7          	jalr	388(ra) # 4ae <tswtch>
        printf("Thread switch complete\n");
 332:	00001517          	auipc	a0,0x1
 336:	af650513          	addi	a0,a0,-1290 # e28 <malloc+0x1aa>
 33a:	00001097          	auipc	ra,0x1
 33e:	88c080e7          	jalr	-1908(ra) # bc6 <printf>
    }
}
 342:	60e2                	ld	ra,24(sp)
 344:	6442                	ld	s0,16(sp)
 346:	64a2                	ld	s1,8(sp)
 348:	6902                	ld	s2,0(sp)
 34a:	6105                	addi	sp,sp,32
 34c:	8082                	ret
 34e:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
 350:	87ba                	mv	a5,a4
 352:	bf79                	j	2f0 <tsched+0x46>
 354:	00001797          	auipc	a5,0x1
 358:	ecc7b783          	ld	a5,-308(a5) # 1220 <threads>
 35c:	5fb4                	lw	a3,120(a5)
 35e:	470d                	li	a4,3
 360:	f8e688e3          	beq	a3,a4,2f0 <tsched+0x46>
 364:	8082                	ret

0000000000000366 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 366:	7179                	addi	sp,sp,-48
 368:	f406                	sd	ra,40(sp)
 36a:	f022                	sd	s0,32(sp)
 36c:	ec26                	sd	s1,24(sp)
 36e:	e84a                	sd	s2,16(sp)
 370:	e44e                	sd	s3,8(sp)
 372:	1800                	addi	s0,sp,48
 374:	84aa                	mv	s1,a0
 376:	89b2                	mv	s3,a2
 378:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 37a:	09000513          	li	a0,144
 37e:	00001097          	auipc	ra,0x1
 382:	900080e7          	jalr	-1792(ra) # c7e <malloc>
 386:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 388:	478d                	li	a5,3
 38a:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 38c:	609c                	ld	a5,0(s1)
 38e:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 392:	609c                	ld	a5,0(s1)
 394:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
 398:	00001717          	auipc	a4,0x1
 39c:	c6870713          	addi	a4,a4,-920 # 1000 <next_tid>
 3a0:	431c                	lw	a5,0(a4)
 3a2:	0017869b          	addiw	a3,a5,1
 3a6:	c314                	sw	a3,0(a4)
 3a8:	6098                	ld	a4,0(s1)
 3aa:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
 3ae:	00001717          	auipc	a4,0x1
 3b2:	e7270713          	addi	a4,a4,-398 # 1220 <threads>
 3b6:	4781                	li	a5,0
 3b8:	4641                	li	a2,16
    if (threads[i] == NULL) {
 3ba:	6314                	ld	a3,0(a4)
 3bc:	ce81                	beqz	a3,3d4 <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
 3be:	2785                	addiw	a5,a5,1
 3c0:	0721                	addi	a4,a4,8
 3c2:	fec79ce3          	bne	a5,a2,3ba <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
 3c6:	70a2                	ld	ra,40(sp)
 3c8:	7402                	ld	s0,32(sp)
 3ca:	64e2                	ld	s1,24(sp)
 3cc:	6942                	ld	s2,16(sp)
 3ce:	69a2                	ld	s3,8(sp)
 3d0:	6145                	addi	sp,sp,48
 3d2:	8082                	ret
        threads[i] = *thread;
 3d4:	6094                	ld	a3,0(s1)
 3d6:	078e                	slli	a5,a5,0x3
 3d8:	00001717          	auipc	a4,0x1
 3dc:	e4870713          	addi	a4,a4,-440 # 1220 <threads>
 3e0:	97ba                	add	a5,a5,a4
 3e2:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
 3e4:	0006c583          	lbu	a1,0(a3)
 3e8:	00001517          	auipc	a0,0x1
 3ec:	a5850513          	addi	a0,a0,-1448 # e40 <malloc+0x1c2>
 3f0:	00000097          	auipc	ra,0x0
 3f4:	7d6080e7          	jalr	2006(ra) # bc6 <printf>
        break;
 3f8:	b7f9                	j	3c6 <tcreate+0x60>

00000000000003fa <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 3fa:	7179                	addi	sp,sp,-48
 3fc:	f406                	sd	ra,40(sp)
 3fe:	f022                	sd	s0,32(sp)
 400:	ec26                	sd	s1,24(sp)
 402:	e84a                	sd	s2,16(sp)
 404:	e44e                	sd	s3,8(sp)
 406:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
 408:	00001797          	auipc	a5,0x1
 40c:	e1878793          	addi	a5,a5,-488 # 1220 <threads>
 410:	00001697          	auipc	a3,0x1
 414:	e9068693          	addi	a3,a3,-368 # 12a0 <base>
 418:	a021                	j	420 <tjoin+0x26>
 41a:	07a1                	addi	a5,a5,8
 41c:	04d78763          	beq	a5,a3,46a <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
 420:	6384                	ld	s1,0(a5)
 422:	dce5                	beqz	s1,41a <tjoin+0x20>
 424:	0004c703          	lbu	a4,0(s1)
 428:	fea719e3          	bne	a4,a0,41a <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
 42c:	5cb8                	lw	a4,120(s1)
 42e:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 430:	00001997          	auipc	s3,0x1
 434:	a4098993          	addi	s3,s3,-1472 # e70 <malloc+0x1f2>
    while (target_thread->state != EXITED) {
 438:	4919                	li	s2,6
 43a:	02f70a63          	beq	a4,a5,46e <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 43e:	0004c583          	lbu	a1,0(s1)
 442:	854e                	mv	a0,s3
 444:	00000097          	auipc	ra,0x0
 448:	782080e7          	jalr	1922(ra) # bc6 <printf>
        tsched();
 44c:	00000097          	auipc	ra,0x0
 450:	e5e080e7          	jalr	-418(ra) # 2aa <tsched>
    while (target_thread->state != EXITED) {
 454:	5cbc                	lw	a5,120(s1)
 456:	ff2794e3          	bne	a5,s2,43e <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
 45a:	4501                	li	a0,0
}
 45c:	70a2                	ld	ra,40(sp)
 45e:	7402                	ld	s0,32(sp)
 460:	64e2                	ld	s1,24(sp)
 462:	6942                	ld	s2,16(sp)
 464:	69a2                	ld	s3,8(sp)
 466:	6145                	addi	sp,sp,48
 468:	8082                	ret
        return -1;
 46a:	557d                	li	a0,-1
 46c:	bfc5                	j	45c <tjoin+0x62>
    return 0;
 46e:	4501                	li	a0,0
 470:	b7f5                	j	45c <tjoin+0x62>

0000000000000472 <tyield>:


void tyield()
{
 472:	1141                	addi	sp,sp,-16
 474:	e406                	sd	ra,8(sp)
 476:	e022                	sd	s0,0(sp)
 478:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 47a:	00001797          	auipc	a5,0x1
 47e:	b967b783          	ld	a5,-1130(a5) # 1010 <current_thread>
 482:	470d                	li	a4,3
 484:	dfb8                	sw	a4,120(a5)
    tsched();
 486:	00000097          	auipc	ra,0x0
 48a:	e24080e7          	jalr	-476(ra) # 2aa <tsched>
}
 48e:	60a2                	ld	ra,8(sp)
 490:	6402                	ld	s0,0(sp)
 492:	0141                	addi	sp,sp,16
 494:	8082                	ret

0000000000000496 <twhoami>:

uint8 twhoami()
{
 496:	1141                	addi	sp,sp,-16
 498:	e422                	sd	s0,8(sp)
 49a:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
 49c:	00001797          	auipc	a5,0x1
 4a0:	b747b783          	ld	a5,-1164(a5) # 1010 <current_thread>
 4a4:	0007c503          	lbu	a0,0(a5)
 4a8:	6422                	ld	s0,8(sp)
 4aa:	0141                	addi	sp,sp,16
 4ac:	8082                	ret

00000000000004ae <tswtch>:
 4ae:	00153023          	sd	ra,0(a0)
 4b2:	00253423          	sd	sp,8(a0)
 4b6:	e900                	sd	s0,16(a0)
 4b8:	ed04                	sd	s1,24(a0)
 4ba:	03253023          	sd	s2,32(a0)
 4be:	03353423          	sd	s3,40(a0)
 4c2:	03453823          	sd	s4,48(a0)
 4c6:	03553c23          	sd	s5,56(a0)
 4ca:	05653023          	sd	s6,64(a0)
 4ce:	05753423          	sd	s7,72(a0)
 4d2:	05853823          	sd	s8,80(a0)
 4d6:	05953c23          	sd	s9,88(a0)
 4da:	07a53023          	sd	s10,96(a0)
 4de:	07b53423          	sd	s11,104(a0)
 4e2:	0005b083          	ld	ra,0(a1)
 4e6:	0085b103          	ld	sp,8(a1)
 4ea:	6980                	ld	s0,16(a1)
 4ec:	6d84                	ld	s1,24(a1)
 4ee:	0205b903          	ld	s2,32(a1)
 4f2:	0285b983          	ld	s3,40(a1)
 4f6:	0305ba03          	ld	s4,48(a1)
 4fa:	0385ba83          	ld	s5,56(a1)
 4fe:	0405bb03          	ld	s6,64(a1)
 502:	0485bb83          	ld	s7,72(a1)
 506:	0505bc03          	ld	s8,80(a1)
 50a:	0585bc83          	ld	s9,88(a1)
 50e:	0605bd03          	ld	s10,96(a1)
 512:	0685bd83          	ld	s11,104(a1)
 516:	8082                	ret

0000000000000518 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 518:	715d                	addi	sp,sp,-80
 51a:	e486                	sd	ra,72(sp)
 51c:	e0a2                	sd	s0,64(sp)
 51e:	fc26                	sd	s1,56(sp)
 520:	f84a                	sd	s2,48(sp)
 522:	f44e                	sd	s3,40(sp)
 524:	f052                	sd	s4,32(sp)
 526:	ec56                	sd	s5,24(sp)
 528:	e85a                	sd	s6,16(sp)
 52a:	e45e                	sd	s7,8(sp)
 52c:	0880                	addi	s0,sp,80
 52e:	892a                	mv	s2,a0
 530:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
 532:	00001517          	auipc	a0,0x1
 536:	95e50513          	addi	a0,a0,-1698 # e90 <malloc+0x212>
 53a:	00000097          	auipc	ra,0x0
 53e:	68c080e7          	jalr	1676(ra) # bc6 <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 542:	09000513          	li	a0,144
 546:	00000097          	auipc	ra,0x0
 54a:	738080e7          	jalr	1848(ra) # c7e <malloc>

    main_thread->tid = 0;
 54e:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
 552:	4791                	li	a5,4
 554:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 556:	00001797          	auipc	a5,0x1
 55a:	aaa7bd23          	sd	a0,-1350(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 55e:	00001a17          	auipc	s4,0x1
 562:	cc2a0a13          	addi	s4,s4,-830 # 1220 <threads>
 566:	00001497          	auipc	s1,0x1
 56a:	d3a48493          	addi	s1,s1,-710 # 12a0 <base>
    current_thread = main_thread;
 56e:	87d2                	mv	a5,s4
        threads[i] = NULL;
 570:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 574:	07a1                	addi	a5,a5,8
 576:	fe979de3          	bne	a5,s1,570 <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 57a:	00001797          	auipc	a5,0x1
 57e:	caa7b323          	sd	a0,-858(a5) # 1220 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 582:	85ce                	mv	a1,s3
 584:	854a                	mv	a0,s2
 586:	00000097          	auipc	ra,0x0
 58a:	b68080e7          	jalr	-1176(ra) # ee <main>
 58e:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
 590:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 592:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
 594:	00001a97          	auipc	s5,0x1
 598:	91ca8a93          	addi	s5,s5,-1764 # eb0 <malloc+0x232>
 59c:	a03d                	j	5ca <_main+0xb2>
        for (int i = 0; i < 16; i++) {
 59e:	07a1                	addi	a5,a5,8
 5a0:	00978963          	beq	a5,s1,5b2 <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 5a4:	6398                	ld	a4,0(a5)
 5a6:	df65                	beqz	a4,59e <_main+0x86>
 5a8:	5f38                	lw	a4,120(a4)
 5aa:	ff370ae3          	beq	a4,s3,59e <_main+0x86>
                running_threads++;
 5ae:	2905                	addiw	s2,s2,1
 5b0:	b7fd                	j	59e <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
 5b2:	85ca                	mv	a1,s2
 5b4:	8556                	mv	a0,s5
 5b6:	00000097          	auipc	ra,0x0
 5ba:	610080e7          	jalr	1552(ra) # bc6 <printf>
        if (running_threads > 0) {
 5be:	01205963          	blez	s2,5d0 <_main+0xb8>
            tsched(); // Schedule another thread to run
 5c2:	00000097          	auipc	ra,0x0
 5c6:	ce8080e7          	jalr	-792(ra) # 2aa <tsched>
    current_thread = main_thread;
 5ca:	87d2                	mv	a5,s4
        running_threads = 0;
 5cc:	895a                	mv	s2,s6
 5ce:	bfd9                	j	5a4 <_main+0x8c>
        }
    }

    exit(res);
 5d0:	855e                	mv	a0,s7
 5d2:	00000097          	auipc	ra,0x0
 5d6:	274080e7          	jalr	628(ra) # 846 <exit>

00000000000005da <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 5da:	1141                	addi	sp,sp,-16
 5dc:	e422                	sd	s0,8(sp)
 5de:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 5e0:	87aa                	mv	a5,a0
 5e2:	0585                	addi	a1,a1,1
 5e4:	0785                	addi	a5,a5,1
 5e6:	fff5c703          	lbu	a4,-1(a1)
 5ea:	fee78fa3          	sb	a4,-1(a5)
 5ee:	fb75                	bnez	a4,5e2 <strcpy+0x8>
        ;
    return os;
}
 5f0:	6422                	ld	s0,8(sp)
 5f2:	0141                	addi	sp,sp,16
 5f4:	8082                	ret

00000000000005f6 <strcmp>:

int strcmp(const char *p, const char *q)
{
 5f6:	1141                	addi	sp,sp,-16
 5f8:	e422                	sd	s0,8(sp)
 5fa:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 5fc:	00054783          	lbu	a5,0(a0)
 600:	cb91                	beqz	a5,614 <strcmp+0x1e>
 602:	0005c703          	lbu	a4,0(a1)
 606:	00f71763          	bne	a4,a5,614 <strcmp+0x1e>
        p++, q++;
 60a:	0505                	addi	a0,a0,1
 60c:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 60e:	00054783          	lbu	a5,0(a0)
 612:	fbe5                	bnez	a5,602 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 614:	0005c503          	lbu	a0,0(a1)
}
 618:	40a7853b          	subw	a0,a5,a0
 61c:	6422                	ld	s0,8(sp)
 61e:	0141                	addi	sp,sp,16
 620:	8082                	ret

0000000000000622 <strlen>:

uint strlen(const char *s)
{
 622:	1141                	addi	sp,sp,-16
 624:	e422                	sd	s0,8(sp)
 626:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 628:	00054783          	lbu	a5,0(a0)
 62c:	cf91                	beqz	a5,648 <strlen+0x26>
 62e:	0505                	addi	a0,a0,1
 630:	87aa                	mv	a5,a0
 632:	86be                	mv	a3,a5
 634:	0785                	addi	a5,a5,1
 636:	fff7c703          	lbu	a4,-1(a5)
 63a:	ff65                	bnez	a4,632 <strlen+0x10>
 63c:	40a6853b          	subw	a0,a3,a0
 640:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 642:	6422                	ld	s0,8(sp)
 644:	0141                	addi	sp,sp,16
 646:	8082                	ret
    for (n = 0; s[n]; n++)
 648:	4501                	li	a0,0
 64a:	bfe5                	j	642 <strlen+0x20>

000000000000064c <memset>:

void *
memset(void *dst, int c, uint n)
{
 64c:	1141                	addi	sp,sp,-16
 64e:	e422                	sd	s0,8(sp)
 650:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 652:	ca19                	beqz	a2,668 <memset+0x1c>
 654:	87aa                	mv	a5,a0
 656:	1602                	slli	a2,a2,0x20
 658:	9201                	srli	a2,a2,0x20
 65a:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 65e:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 662:	0785                	addi	a5,a5,1
 664:	fee79de3          	bne	a5,a4,65e <memset+0x12>
    }
    return dst;
}
 668:	6422                	ld	s0,8(sp)
 66a:	0141                	addi	sp,sp,16
 66c:	8082                	ret

000000000000066e <strchr>:

char *
strchr(const char *s, char c)
{
 66e:	1141                	addi	sp,sp,-16
 670:	e422                	sd	s0,8(sp)
 672:	0800                	addi	s0,sp,16
    for (; *s; s++)
 674:	00054783          	lbu	a5,0(a0)
 678:	cb99                	beqz	a5,68e <strchr+0x20>
        if (*s == c)
 67a:	00f58763          	beq	a1,a5,688 <strchr+0x1a>
    for (; *s; s++)
 67e:	0505                	addi	a0,a0,1
 680:	00054783          	lbu	a5,0(a0)
 684:	fbfd                	bnez	a5,67a <strchr+0xc>
            return (char *)s;
    return 0;
 686:	4501                	li	a0,0
}
 688:	6422                	ld	s0,8(sp)
 68a:	0141                	addi	sp,sp,16
 68c:	8082                	ret
    return 0;
 68e:	4501                	li	a0,0
 690:	bfe5                	j	688 <strchr+0x1a>

0000000000000692 <gets>:

char *
gets(char *buf, int max)
{
 692:	711d                	addi	sp,sp,-96
 694:	ec86                	sd	ra,88(sp)
 696:	e8a2                	sd	s0,80(sp)
 698:	e4a6                	sd	s1,72(sp)
 69a:	e0ca                	sd	s2,64(sp)
 69c:	fc4e                	sd	s3,56(sp)
 69e:	f852                	sd	s4,48(sp)
 6a0:	f456                	sd	s5,40(sp)
 6a2:	f05a                	sd	s6,32(sp)
 6a4:	ec5e                	sd	s7,24(sp)
 6a6:	1080                	addi	s0,sp,96
 6a8:	8baa                	mv	s7,a0
 6aa:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 6ac:	892a                	mv	s2,a0
 6ae:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 6b0:	4aa9                	li	s5,10
 6b2:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 6b4:	89a6                	mv	s3,s1
 6b6:	2485                	addiw	s1,s1,1
 6b8:	0344d863          	bge	s1,s4,6e8 <gets+0x56>
        cc = read(0, &c, 1);
 6bc:	4605                	li	a2,1
 6be:	faf40593          	addi	a1,s0,-81
 6c2:	4501                	li	a0,0
 6c4:	00000097          	auipc	ra,0x0
 6c8:	19a080e7          	jalr	410(ra) # 85e <read>
        if (cc < 1)
 6cc:	00a05e63          	blez	a0,6e8 <gets+0x56>
        buf[i++] = c;
 6d0:	faf44783          	lbu	a5,-81(s0)
 6d4:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 6d8:	01578763          	beq	a5,s5,6e6 <gets+0x54>
 6dc:	0905                	addi	s2,s2,1
 6de:	fd679be3          	bne	a5,s6,6b4 <gets+0x22>
    for (i = 0; i + 1 < max;)
 6e2:	89a6                	mv	s3,s1
 6e4:	a011                	j	6e8 <gets+0x56>
 6e6:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 6e8:	99de                	add	s3,s3,s7
 6ea:	00098023          	sb	zero,0(s3)
    return buf;
}
 6ee:	855e                	mv	a0,s7
 6f0:	60e6                	ld	ra,88(sp)
 6f2:	6446                	ld	s0,80(sp)
 6f4:	64a6                	ld	s1,72(sp)
 6f6:	6906                	ld	s2,64(sp)
 6f8:	79e2                	ld	s3,56(sp)
 6fa:	7a42                	ld	s4,48(sp)
 6fc:	7aa2                	ld	s5,40(sp)
 6fe:	7b02                	ld	s6,32(sp)
 700:	6be2                	ld	s7,24(sp)
 702:	6125                	addi	sp,sp,96
 704:	8082                	ret

0000000000000706 <stat>:

int stat(const char *n, struct stat *st)
{
 706:	1101                	addi	sp,sp,-32
 708:	ec06                	sd	ra,24(sp)
 70a:	e822                	sd	s0,16(sp)
 70c:	e426                	sd	s1,8(sp)
 70e:	e04a                	sd	s2,0(sp)
 710:	1000                	addi	s0,sp,32
 712:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 714:	4581                	li	a1,0
 716:	00000097          	auipc	ra,0x0
 71a:	170080e7          	jalr	368(ra) # 886 <open>
    if (fd < 0)
 71e:	02054563          	bltz	a0,748 <stat+0x42>
 722:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 724:	85ca                	mv	a1,s2
 726:	00000097          	auipc	ra,0x0
 72a:	178080e7          	jalr	376(ra) # 89e <fstat>
 72e:	892a                	mv	s2,a0
    close(fd);
 730:	8526                	mv	a0,s1
 732:	00000097          	auipc	ra,0x0
 736:	13c080e7          	jalr	316(ra) # 86e <close>
    return r;
}
 73a:	854a                	mv	a0,s2
 73c:	60e2                	ld	ra,24(sp)
 73e:	6442                	ld	s0,16(sp)
 740:	64a2                	ld	s1,8(sp)
 742:	6902                	ld	s2,0(sp)
 744:	6105                	addi	sp,sp,32
 746:	8082                	ret
        return -1;
 748:	597d                	li	s2,-1
 74a:	bfc5                	j	73a <stat+0x34>

000000000000074c <atoi>:

int atoi(const char *s)
{
 74c:	1141                	addi	sp,sp,-16
 74e:	e422                	sd	s0,8(sp)
 750:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 752:	00054683          	lbu	a3,0(a0)
 756:	fd06879b          	addiw	a5,a3,-48
 75a:	0ff7f793          	zext.b	a5,a5
 75e:	4625                	li	a2,9
 760:	02f66863          	bltu	a2,a5,790 <atoi+0x44>
 764:	872a                	mv	a4,a0
    n = 0;
 766:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 768:	0705                	addi	a4,a4,1
 76a:	0025179b          	slliw	a5,a0,0x2
 76e:	9fa9                	addw	a5,a5,a0
 770:	0017979b          	slliw	a5,a5,0x1
 774:	9fb5                	addw	a5,a5,a3
 776:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 77a:	00074683          	lbu	a3,0(a4)
 77e:	fd06879b          	addiw	a5,a3,-48
 782:	0ff7f793          	zext.b	a5,a5
 786:	fef671e3          	bgeu	a2,a5,768 <atoi+0x1c>
    return n;
}
 78a:	6422                	ld	s0,8(sp)
 78c:	0141                	addi	sp,sp,16
 78e:	8082                	ret
    n = 0;
 790:	4501                	li	a0,0
 792:	bfe5                	j	78a <atoi+0x3e>

0000000000000794 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 794:	1141                	addi	sp,sp,-16
 796:	e422                	sd	s0,8(sp)
 798:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 79a:	02b57463          	bgeu	a0,a1,7c2 <memmove+0x2e>
    {
        while (n-- > 0)
 79e:	00c05f63          	blez	a2,7bc <memmove+0x28>
 7a2:	1602                	slli	a2,a2,0x20
 7a4:	9201                	srli	a2,a2,0x20
 7a6:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 7aa:	872a                	mv	a4,a0
            *dst++ = *src++;
 7ac:	0585                	addi	a1,a1,1
 7ae:	0705                	addi	a4,a4,1
 7b0:	fff5c683          	lbu	a3,-1(a1)
 7b4:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 7b8:	fee79ae3          	bne	a5,a4,7ac <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 7bc:	6422                	ld	s0,8(sp)
 7be:	0141                	addi	sp,sp,16
 7c0:	8082                	ret
        dst += n;
 7c2:	00c50733          	add	a4,a0,a2
        src += n;
 7c6:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 7c8:	fec05ae3          	blez	a2,7bc <memmove+0x28>
 7cc:	fff6079b          	addiw	a5,a2,-1
 7d0:	1782                	slli	a5,a5,0x20
 7d2:	9381                	srli	a5,a5,0x20
 7d4:	fff7c793          	not	a5,a5
 7d8:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 7da:	15fd                	addi	a1,a1,-1
 7dc:	177d                	addi	a4,a4,-1
 7de:	0005c683          	lbu	a3,0(a1)
 7e2:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 7e6:	fee79ae3          	bne	a5,a4,7da <memmove+0x46>
 7ea:	bfc9                	j	7bc <memmove+0x28>

00000000000007ec <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 7ec:	1141                	addi	sp,sp,-16
 7ee:	e422                	sd	s0,8(sp)
 7f0:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 7f2:	ca05                	beqz	a2,822 <memcmp+0x36>
 7f4:	fff6069b          	addiw	a3,a2,-1
 7f8:	1682                	slli	a3,a3,0x20
 7fa:	9281                	srli	a3,a3,0x20
 7fc:	0685                	addi	a3,a3,1
 7fe:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 800:	00054783          	lbu	a5,0(a0)
 804:	0005c703          	lbu	a4,0(a1)
 808:	00e79863          	bne	a5,a4,818 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 80c:	0505                	addi	a0,a0,1
        p2++;
 80e:	0585                	addi	a1,a1,1
    while (n-- > 0)
 810:	fed518e3          	bne	a0,a3,800 <memcmp+0x14>
    }
    return 0;
 814:	4501                	li	a0,0
 816:	a019                	j	81c <memcmp+0x30>
            return *p1 - *p2;
 818:	40e7853b          	subw	a0,a5,a4
}
 81c:	6422                	ld	s0,8(sp)
 81e:	0141                	addi	sp,sp,16
 820:	8082                	ret
    return 0;
 822:	4501                	li	a0,0
 824:	bfe5                	j	81c <memcmp+0x30>

0000000000000826 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 826:	1141                	addi	sp,sp,-16
 828:	e406                	sd	ra,8(sp)
 82a:	e022                	sd	s0,0(sp)
 82c:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 82e:	00000097          	auipc	ra,0x0
 832:	f66080e7          	jalr	-154(ra) # 794 <memmove>
}
 836:	60a2                	ld	ra,8(sp)
 838:	6402                	ld	s0,0(sp)
 83a:	0141                	addi	sp,sp,16
 83c:	8082                	ret

000000000000083e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 83e:	4885                	li	a7,1
 ecall
 840:	00000073          	ecall
 ret
 844:	8082                	ret

0000000000000846 <exit>:
.global exit
exit:
 li a7, SYS_exit
 846:	4889                	li	a7,2
 ecall
 848:	00000073          	ecall
 ret
 84c:	8082                	ret

000000000000084e <wait>:
.global wait
wait:
 li a7, SYS_wait
 84e:	488d                	li	a7,3
 ecall
 850:	00000073          	ecall
 ret
 854:	8082                	ret

0000000000000856 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 856:	4891                	li	a7,4
 ecall
 858:	00000073          	ecall
 ret
 85c:	8082                	ret

000000000000085e <read>:
.global read
read:
 li a7, SYS_read
 85e:	4895                	li	a7,5
 ecall
 860:	00000073          	ecall
 ret
 864:	8082                	ret

0000000000000866 <write>:
.global write
write:
 li a7, SYS_write
 866:	48c1                	li	a7,16
 ecall
 868:	00000073          	ecall
 ret
 86c:	8082                	ret

000000000000086e <close>:
.global close
close:
 li a7, SYS_close
 86e:	48d5                	li	a7,21
 ecall
 870:	00000073          	ecall
 ret
 874:	8082                	ret

0000000000000876 <kill>:
.global kill
kill:
 li a7, SYS_kill
 876:	4899                	li	a7,6
 ecall
 878:	00000073          	ecall
 ret
 87c:	8082                	ret

000000000000087e <exec>:
.global exec
exec:
 li a7, SYS_exec
 87e:	489d                	li	a7,7
 ecall
 880:	00000073          	ecall
 ret
 884:	8082                	ret

0000000000000886 <open>:
.global open
open:
 li a7, SYS_open
 886:	48bd                	li	a7,15
 ecall
 888:	00000073          	ecall
 ret
 88c:	8082                	ret

000000000000088e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 88e:	48c5                	li	a7,17
 ecall
 890:	00000073          	ecall
 ret
 894:	8082                	ret

0000000000000896 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 896:	48c9                	li	a7,18
 ecall
 898:	00000073          	ecall
 ret
 89c:	8082                	ret

000000000000089e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 89e:	48a1                	li	a7,8
 ecall
 8a0:	00000073          	ecall
 ret
 8a4:	8082                	ret

00000000000008a6 <link>:
.global link
link:
 li a7, SYS_link
 8a6:	48cd                	li	a7,19
 ecall
 8a8:	00000073          	ecall
 ret
 8ac:	8082                	ret

00000000000008ae <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 8ae:	48d1                	li	a7,20
 ecall
 8b0:	00000073          	ecall
 ret
 8b4:	8082                	ret

00000000000008b6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 8b6:	48a5                	li	a7,9
 ecall
 8b8:	00000073          	ecall
 ret
 8bc:	8082                	ret

00000000000008be <dup>:
.global dup
dup:
 li a7, SYS_dup
 8be:	48a9                	li	a7,10
 ecall
 8c0:	00000073          	ecall
 ret
 8c4:	8082                	ret

00000000000008c6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 8c6:	48ad                	li	a7,11
 ecall
 8c8:	00000073          	ecall
 ret
 8cc:	8082                	ret

00000000000008ce <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 8ce:	48b1                	li	a7,12
 ecall
 8d0:	00000073          	ecall
 ret
 8d4:	8082                	ret

00000000000008d6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 8d6:	48b5                	li	a7,13
 ecall
 8d8:	00000073          	ecall
 ret
 8dc:	8082                	ret

00000000000008de <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 8de:	48b9                	li	a7,14
 ecall
 8e0:	00000073          	ecall
 ret
 8e4:	8082                	ret

00000000000008e6 <ps>:
.global ps
ps:
 li a7, SYS_ps
 8e6:	48d9                	li	a7,22
 ecall
 8e8:	00000073          	ecall
 ret
 8ec:	8082                	ret

00000000000008ee <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 8ee:	48dd                	li	a7,23
 ecall
 8f0:	00000073          	ecall
 ret
 8f4:	8082                	ret

00000000000008f6 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 8f6:	48e1                	li	a7,24
 ecall
 8f8:	00000073          	ecall
 ret
 8fc:	8082                	ret

00000000000008fe <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 8fe:	1101                	addi	sp,sp,-32
 900:	ec06                	sd	ra,24(sp)
 902:	e822                	sd	s0,16(sp)
 904:	1000                	addi	s0,sp,32
 906:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 90a:	4605                	li	a2,1
 90c:	fef40593          	addi	a1,s0,-17
 910:	00000097          	auipc	ra,0x0
 914:	f56080e7          	jalr	-170(ra) # 866 <write>
}
 918:	60e2                	ld	ra,24(sp)
 91a:	6442                	ld	s0,16(sp)
 91c:	6105                	addi	sp,sp,32
 91e:	8082                	ret

0000000000000920 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 920:	7139                	addi	sp,sp,-64
 922:	fc06                	sd	ra,56(sp)
 924:	f822                	sd	s0,48(sp)
 926:	f426                	sd	s1,40(sp)
 928:	f04a                	sd	s2,32(sp)
 92a:	ec4e                	sd	s3,24(sp)
 92c:	0080                	addi	s0,sp,64
 92e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 930:	c299                	beqz	a3,936 <printint+0x16>
 932:	0805c963          	bltz	a1,9c4 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 936:	2581                	sext.w	a1,a1
  neg = 0;
 938:	4881                	li	a7,0
 93a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 93e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 940:	2601                	sext.w	a2,a2
 942:	00000517          	auipc	a0,0x0
 946:	5ee50513          	addi	a0,a0,1518 # f30 <digits>
 94a:	883a                	mv	a6,a4
 94c:	2705                	addiw	a4,a4,1
 94e:	02c5f7bb          	remuw	a5,a1,a2
 952:	1782                	slli	a5,a5,0x20
 954:	9381                	srli	a5,a5,0x20
 956:	97aa                	add	a5,a5,a0
 958:	0007c783          	lbu	a5,0(a5)
 95c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 960:	0005879b          	sext.w	a5,a1
 964:	02c5d5bb          	divuw	a1,a1,a2
 968:	0685                	addi	a3,a3,1
 96a:	fec7f0e3          	bgeu	a5,a2,94a <printint+0x2a>
  if(neg)
 96e:	00088c63          	beqz	a7,986 <printint+0x66>
    buf[i++] = '-';
 972:	fd070793          	addi	a5,a4,-48
 976:	00878733          	add	a4,a5,s0
 97a:	02d00793          	li	a5,45
 97e:	fef70823          	sb	a5,-16(a4)
 982:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 986:	02e05863          	blez	a4,9b6 <printint+0x96>
 98a:	fc040793          	addi	a5,s0,-64
 98e:	00e78933          	add	s2,a5,a4
 992:	fff78993          	addi	s3,a5,-1
 996:	99ba                	add	s3,s3,a4
 998:	377d                	addiw	a4,a4,-1
 99a:	1702                	slli	a4,a4,0x20
 99c:	9301                	srli	a4,a4,0x20
 99e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 9a2:	fff94583          	lbu	a1,-1(s2)
 9a6:	8526                	mv	a0,s1
 9a8:	00000097          	auipc	ra,0x0
 9ac:	f56080e7          	jalr	-170(ra) # 8fe <putc>
  while(--i >= 0)
 9b0:	197d                	addi	s2,s2,-1
 9b2:	ff3918e3          	bne	s2,s3,9a2 <printint+0x82>
}
 9b6:	70e2                	ld	ra,56(sp)
 9b8:	7442                	ld	s0,48(sp)
 9ba:	74a2                	ld	s1,40(sp)
 9bc:	7902                	ld	s2,32(sp)
 9be:	69e2                	ld	s3,24(sp)
 9c0:	6121                	addi	sp,sp,64
 9c2:	8082                	ret
    x = -xx;
 9c4:	40b005bb          	negw	a1,a1
    neg = 1;
 9c8:	4885                	li	a7,1
    x = -xx;
 9ca:	bf85                	j	93a <printint+0x1a>

00000000000009cc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 9cc:	715d                	addi	sp,sp,-80
 9ce:	e486                	sd	ra,72(sp)
 9d0:	e0a2                	sd	s0,64(sp)
 9d2:	fc26                	sd	s1,56(sp)
 9d4:	f84a                	sd	s2,48(sp)
 9d6:	f44e                	sd	s3,40(sp)
 9d8:	f052                	sd	s4,32(sp)
 9da:	ec56                	sd	s5,24(sp)
 9dc:	e85a                	sd	s6,16(sp)
 9de:	e45e                	sd	s7,8(sp)
 9e0:	e062                	sd	s8,0(sp)
 9e2:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 9e4:	0005c903          	lbu	s2,0(a1)
 9e8:	18090c63          	beqz	s2,b80 <vprintf+0x1b4>
 9ec:	8aaa                	mv	s5,a0
 9ee:	8bb2                	mv	s7,a2
 9f0:	00158493          	addi	s1,a1,1
  state = 0;
 9f4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 9f6:	02500a13          	li	s4,37
 9fa:	4b55                	li	s6,21
 9fc:	a839                	j	a1a <vprintf+0x4e>
        putc(fd, c);
 9fe:	85ca                	mv	a1,s2
 a00:	8556                	mv	a0,s5
 a02:	00000097          	auipc	ra,0x0
 a06:	efc080e7          	jalr	-260(ra) # 8fe <putc>
 a0a:	a019                	j	a10 <vprintf+0x44>
    } else if(state == '%'){
 a0c:	01498d63          	beq	s3,s4,a26 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 a10:	0485                	addi	s1,s1,1
 a12:	fff4c903          	lbu	s2,-1(s1)
 a16:	16090563          	beqz	s2,b80 <vprintf+0x1b4>
    if(state == 0){
 a1a:	fe0999e3          	bnez	s3,a0c <vprintf+0x40>
      if(c == '%'){
 a1e:	ff4910e3          	bne	s2,s4,9fe <vprintf+0x32>
        state = '%';
 a22:	89d2                	mv	s3,s4
 a24:	b7f5                	j	a10 <vprintf+0x44>
      if(c == 'd'){
 a26:	13490263          	beq	s2,s4,b4a <vprintf+0x17e>
 a2a:	f9d9079b          	addiw	a5,s2,-99
 a2e:	0ff7f793          	zext.b	a5,a5
 a32:	12fb6563          	bltu	s6,a5,b5c <vprintf+0x190>
 a36:	f9d9079b          	addiw	a5,s2,-99
 a3a:	0ff7f713          	zext.b	a4,a5
 a3e:	10eb6f63          	bltu	s6,a4,b5c <vprintf+0x190>
 a42:	00271793          	slli	a5,a4,0x2
 a46:	00000717          	auipc	a4,0x0
 a4a:	49270713          	addi	a4,a4,1170 # ed8 <malloc+0x25a>
 a4e:	97ba                	add	a5,a5,a4
 a50:	439c                	lw	a5,0(a5)
 a52:	97ba                	add	a5,a5,a4
 a54:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 a56:	008b8913          	addi	s2,s7,8
 a5a:	4685                	li	a3,1
 a5c:	4629                	li	a2,10
 a5e:	000ba583          	lw	a1,0(s7)
 a62:	8556                	mv	a0,s5
 a64:	00000097          	auipc	ra,0x0
 a68:	ebc080e7          	jalr	-324(ra) # 920 <printint>
 a6c:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 a6e:	4981                	li	s3,0
 a70:	b745                	j	a10 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a72:	008b8913          	addi	s2,s7,8
 a76:	4681                	li	a3,0
 a78:	4629                	li	a2,10
 a7a:	000ba583          	lw	a1,0(s7)
 a7e:	8556                	mv	a0,s5
 a80:	00000097          	auipc	ra,0x0
 a84:	ea0080e7          	jalr	-352(ra) # 920 <printint>
 a88:	8bca                	mv	s7,s2
      state = 0;
 a8a:	4981                	li	s3,0
 a8c:	b751                	j	a10 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 a8e:	008b8913          	addi	s2,s7,8
 a92:	4681                	li	a3,0
 a94:	4641                	li	a2,16
 a96:	000ba583          	lw	a1,0(s7)
 a9a:	8556                	mv	a0,s5
 a9c:	00000097          	auipc	ra,0x0
 aa0:	e84080e7          	jalr	-380(ra) # 920 <printint>
 aa4:	8bca                	mv	s7,s2
      state = 0;
 aa6:	4981                	li	s3,0
 aa8:	b7a5                	j	a10 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 aaa:	008b8c13          	addi	s8,s7,8
 aae:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 ab2:	03000593          	li	a1,48
 ab6:	8556                	mv	a0,s5
 ab8:	00000097          	auipc	ra,0x0
 abc:	e46080e7          	jalr	-442(ra) # 8fe <putc>
  putc(fd, 'x');
 ac0:	07800593          	li	a1,120
 ac4:	8556                	mv	a0,s5
 ac6:	00000097          	auipc	ra,0x0
 aca:	e38080e7          	jalr	-456(ra) # 8fe <putc>
 ace:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 ad0:	00000b97          	auipc	s7,0x0
 ad4:	460b8b93          	addi	s7,s7,1120 # f30 <digits>
 ad8:	03c9d793          	srli	a5,s3,0x3c
 adc:	97de                	add	a5,a5,s7
 ade:	0007c583          	lbu	a1,0(a5)
 ae2:	8556                	mv	a0,s5
 ae4:	00000097          	auipc	ra,0x0
 ae8:	e1a080e7          	jalr	-486(ra) # 8fe <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 aec:	0992                	slli	s3,s3,0x4
 aee:	397d                	addiw	s2,s2,-1
 af0:	fe0914e3          	bnez	s2,ad8 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 af4:	8be2                	mv	s7,s8
      state = 0;
 af6:	4981                	li	s3,0
 af8:	bf21                	j	a10 <vprintf+0x44>
        s = va_arg(ap, char*);
 afa:	008b8993          	addi	s3,s7,8
 afe:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 b02:	02090163          	beqz	s2,b24 <vprintf+0x158>
        while(*s != 0){
 b06:	00094583          	lbu	a1,0(s2)
 b0a:	c9a5                	beqz	a1,b7a <vprintf+0x1ae>
          putc(fd, *s);
 b0c:	8556                	mv	a0,s5
 b0e:	00000097          	auipc	ra,0x0
 b12:	df0080e7          	jalr	-528(ra) # 8fe <putc>
          s++;
 b16:	0905                	addi	s2,s2,1
        while(*s != 0){
 b18:	00094583          	lbu	a1,0(s2)
 b1c:	f9e5                	bnez	a1,b0c <vprintf+0x140>
        s = va_arg(ap, char*);
 b1e:	8bce                	mv	s7,s3
      state = 0;
 b20:	4981                	li	s3,0
 b22:	b5fd                	j	a10 <vprintf+0x44>
          s = "(null)";
 b24:	00000917          	auipc	s2,0x0
 b28:	3ac90913          	addi	s2,s2,940 # ed0 <malloc+0x252>
        while(*s != 0){
 b2c:	02800593          	li	a1,40
 b30:	bff1                	j	b0c <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 b32:	008b8913          	addi	s2,s7,8
 b36:	000bc583          	lbu	a1,0(s7)
 b3a:	8556                	mv	a0,s5
 b3c:	00000097          	auipc	ra,0x0
 b40:	dc2080e7          	jalr	-574(ra) # 8fe <putc>
 b44:	8bca                	mv	s7,s2
      state = 0;
 b46:	4981                	li	s3,0
 b48:	b5e1                	j	a10 <vprintf+0x44>
        putc(fd, c);
 b4a:	02500593          	li	a1,37
 b4e:	8556                	mv	a0,s5
 b50:	00000097          	auipc	ra,0x0
 b54:	dae080e7          	jalr	-594(ra) # 8fe <putc>
      state = 0;
 b58:	4981                	li	s3,0
 b5a:	bd5d                	j	a10 <vprintf+0x44>
        putc(fd, '%');
 b5c:	02500593          	li	a1,37
 b60:	8556                	mv	a0,s5
 b62:	00000097          	auipc	ra,0x0
 b66:	d9c080e7          	jalr	-612(ra) # 8fe <putc>
        putc(fd, c);
 b6a:	85ca                	mv	a1,s2
 b6c:	8556                	mv	a0,s5
 b6e:	00000097          	auipc	ra,0x0
 b72:	d90080e7          	jalr	-624(ra) # 8fe <putc>
      state = 0;
 b76:	4981                	li	s3,0
 b78:	bd61                	j	a10 <vprintf+0x44>
        s = va_arg(ap, char*);
 b7a:	8bce                	mv	s7,s3
      state = 0;
 b7c:	4981                	li	s3,0
 b7e:	bd49                	j	a10 <vprintf+0x44>
    }
  }
}
 b80:	60a6                	ld	ra,72(sp)
 b82:	6406                	ld	s0,64(sp)
 b84:	74e2                	ld	s1,56(sp)
 b86:	7942                	ld	s2,48(sp)
 b88:	79a2                	ld	s3,40(sp)
 b8a:	7a02                	ld	s4,32(sp)
 b8c:	6ae2                	ld	s5,24(sp)
 b8e:	6b42                	ld	s6,16(sp)
 b90:	6ba2                	ld	s7,8(sp)
 b92:	6c02                	ld	s8,0(sp)
 b94:	6161                	addi	sp,sp,80
 b96:	8082                	ret

0000000000000b98 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b98:	715d                	addi	sp,sp,-80
 b9a:	ec06                	sd	ra,24(sp)
 b9c:	e822                	sd	s0,16(sp)
 b9e:	1000                	addi	s0,sp,32
 ba0:	e010                	sd	a2,0(s0)
 ba2:	e414                	sd	a3,8(s0)
 ba4:	e818                	sd	a4,16(s0)
 ba6:	ec1c                	sd	a5,24(s0)
 ba8:	03043023          	sd	a6,32(s0)
 bac:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 bb0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 bb4:	8622                	mv	a2,s0
 bb6:	00000097          	auipc	ra,0x0
 bba:	e16080e7          	jalr	-490(ra) # 9cc <vprintf>
}
 bbe:	60e2                	ld	ra,24(sp)
 bc0:	6442                	ld	s0,16(sp)
 bc2:	6161                	addi	sp,sp,80
 bc4:	8082                	ret

0000000000000bc6 <printf>:

void
printf(const char *fmt, ...)
{
 bc6:	711d                	addi	sp,sp,-96
 bc8:	ec06                	sd	ra,24(sp)
 bca:	e822                	sd	s0,16(sp)
 bcc:	1000                	addi	s0,sp,32
 bce:	e40c                	sd	a1,8(s0)
 bd0:	e810                	sd	a2,16(s0)
 bd2:	ec14                	sd	a3,24(s0)
 bd4:	f018                	sd	a4,32(s0)
 bd6:	f41c                	sd	a5,40(s0)
 bd8:	03043823          	sd	a6,48(s0)
 bdc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 be0:	00840613          	addi	a2,s0,8
 be4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 be8:	85aa                	mv	a1,a0
 bea:	4505                	li	a0,1
 bec:	00000097          	auipc	ra,0x0
 bf0:	de0080e7          	jalr	-544(ra) # 9cc <vprintf>
}
 bf4:	60e2                	ld	ra,24(sp)
 bf6:	6442                	ld	s0,16(sp)
 bf8:	6125                	addi	sp,sp,96
 bfa:	8082                	ret

0000000000000bfc <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 bfc:	1141                	addi	sp,sp,-16
 bfe:	e422                	sd	s0,8(sp)
 c00:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 c02:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c06:	00000797          	auipc	a5,0x0
 c0a:	4127b783          	ld	a5,1042(a5) # 1018 <freep>
 c0e:	a02d                	j	c38 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 c10:	4618                	lw	a4,8(a2)
 c12:	9f2d                	addw	a4,a4,a1
 c14:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 c18:	6398                	ld	a4,0(a5)
 c1a:	6310                	ld	a2,0(a4)
 c1c:	a83d                	j	c5a <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 c1e:	ff852703          	lw	a4,-8(a0)
 c22:	9f31                	addw	a4,a4,a2
 c24:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 c26:	ff053683          	ld	a3,-16(a0)
 c2a:	a091                	j	c6e <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c2c:	6398                	ld	a4,0(a5)
 c2e:	00e7e463          	bltu	a5,a4,c36 <free+0x3a>
 c32:	00e6ea63          	bltu	a3,a4,c46 <free+0x4a>
{
 c36:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c38:	fed7fae3          	bgeu	a5,a3,c2c <free+0x30>
 c3c:	6398                	ld	a4,0(a5)
 c3e:	00e6e463          	bltu	a3,a4,c46 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c42:	fee7eae3          	bltu	a5,a4,c36 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 c46:	ff852583          	lw	a1,-8(a0)
 c4a:	6390                	ld	a2,0(a5)
 c4c:	02059813          	slli	a6,a1,0x20
 c50:	01c85713          	srli	a4,a6,0x1c
 c54:	9736                	add	a4,a4,a3
 c56:	fae60de3          	beq	a2,a4,c10 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 c5a:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 c5e:	4790                	lw	a2,8(a5)
 c60:	02061593          	slli	a1,a2,0x20
 c64:	01c5d713          	srli	a4,a1,0x1c
 c68:	973e                	add	a4,a4,a5
 c6a:	fae68ae3          	beq	a3,a4,c1e <free+0x22>
        p->s.ptr = bp->s.ptr;
 c6e:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 c70:	00000717          	auipc	a4,0x0
 c74:	3af73423          	sd	a5,936(a4) # 1018 <freep>
}
 c78:	6422                	ld	s0,8(sp)
 c7a:	0141                	addi	sp,sp,16
 c7c:	8082                	ret

0000000000000c7e <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 c7e:	7139                	addi	sp,sp,-64
 c80:	fc06                	sd	ra,56(sp)
 c82:	f822                	sd	s0,48(sp)
 c84:	f426                	sd	s1,40(sp)
 c86:	f04a                	sd	s2,32(sp)
 c88:	ec4e                	sd	s3,24(sp)
 c8a:	e852                	sd	s4,16(sp)
 c8c:	e456                	sd	s5,8(sp)
 c8e:	e05a                	sd	s6,0(sp)
 c90:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 c92:	02051493          	slli	s1,a0,0x20
 c96:	9081                	srli	s1,s1,0x20
 c98:	04bd                	addi	s1,s1,15
 c9a:	8091                	srli	s1,s1,0x4
 c9c:	0014899b          	addiw	s3,s1,1
 ca0:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 ca2:	00000517          	auipc	a0,0x0
 ca6:	37653503          	ld	a0,886(a0) # 1018 <freep>
 caa:	c515                	beqz	a0,cd6 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 cac:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 cae:	4798                	lw	a4,8(a5)
 cb0:	02977f63          	bgeu	a4,s1,cee <malloc+0x70>
    if (nu < 4096)
 cb4:	8a4e                	mv	s4,s3
 cb6:	0009871b          	sext.w	a4,s3
 cba:	6685                	lui	a3,0x1
 cbc:	00d77363          	bgeu	a4,a3,cc2 <malloc+0x44>
 cc0:	6a05                	lui	s4,0x1
 cc2:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 cc6:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 cca:	00000917          	auipc	s2,0x0
 cce:	34e90913          	addi	s2,s2,846 # 1018 <freep>
    if (p == (char *)-1)
 cd2:	5afd                	li	s5,-1
 cd4:	a895                	j	d48 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 cd6:	00000797          	auipc	a5,0x0
 cda:	5ca78793          	addi	a5,a5,1482 # 12a0 <base>
 cde:	00000717          	auipc	a4,0x0
 ce2:	32f73d23          	sd	a5,826(a4) # 1018 <freep>
 ce6:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 ce8:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 cec:	b7e1                	j	cb4 <malloc+0x36>
            if (p->s.size == nunits)
 cee:	02e48c63          	beq	s1,a4,d26 <malloc+0xa8>
                p->s.size -= nunits;
 cf2:	4137073b          	subw	a4,a4,s3
 cf6:	c798                	sw	a4,8(a5)
                p += p->s.size;
 cf8:	02071693          	slli	a3,a4,0x20
 cfc:	01c6d713          	srli	a4,a3,0x1c
 d00:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 d02:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 d06:	00000717          	auipc	a4,0x0
 d0a:	30a73923          	sd	a0,786(a4) # 1018 <freep>
            return (void *)(p + 1);
 d0e:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 d12:	70e2                	ld	ra,56(sp)
 d14:	7442                	ld	s0,48(sp)
 d16:	74a2                	ld	s1,40(sp)
 d18:	7902                	ld	s2,32(sp)
 d1a:	69e2                	ld	s3,24(sp)
 d1c:	6a42                	ld	s4,16(sp)
 d1e:	6aa2                	ld	s5,8(sp)
 d20:	6b02                	ld	s6,0(sp)
 d22:	6121                	addi	sp,sp,64
 d24:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 d26:	6398                	ld	a4,0(a5)
 d28:	e118                	sd	a4,0(a0)
 d2a:	bff1                	j	d06 <malloc+0x88>
    hp->s.size = nu;
 d2c:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 d30:	0541                	addi	a0,a0,16
 d32:	00000097          	auipc	ra,0x0
 d36:	eca080e7          	jalr	-310(ra) # bfc <free>
    return freep;
 d3a:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 d3e:	d971                	beqz	a0,d12 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 d40:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 d42:	4798                	lw	a4,8(a5)
 d44:	fa9775e3          	bgeu	a4,s1,cee <malloc+0x70>
        if (p == freep)
 d48:	00093703          	ld	a4,0(s2)
 d4c:	853e                	mv	a0,a5
 d4e:	fef719e3          	bne	a4,a5,d40 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 d52:	8552                	mv	a0,s4
 d54:	00000097          	auipc	ra,0x0
 d58:	b7a080e7          	jalr	-1158(ra) # 8ce <sbrk>
    if (p == (char *)-1)
 d5c:	fd5518e3          	bne	a0,s5,d2c <malloc+0xae>
                return 0;
 d60:	4501                	li	a0,0
 d62:	bf45                	j	d12 <malloc+0x94>
