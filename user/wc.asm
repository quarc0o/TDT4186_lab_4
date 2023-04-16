
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
  32:	fe2d8d93          	addi	s11,s11,-30 # 1010 <buf>
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  36:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  38:	00001a17          	auipc	s4,0x1
  3c:	b38a0a13          	addi	s4,s4,-1224 # b70 <malloc+0xf4>
        inword = 0;
  40:	4b81                	li	s7,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  42:	a805                	j	72 <wc+0x72>
      if(strchr(" \r\t\n\v", buf[i]))
  44:	8552                	mv	a0,s4
  46:	00000097          	auipc	ra,0x0
  4a:	426080e7          	jalr	1062(ra) # 46c <strchr>
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
  80:	5e0080e7          	jalr	1504(ra) # 65c <read>
  84:	8b2a                	mv	s6,a0
  86:	00a05963          	blez	a0,98 <wc+0x98>
    for(i=0; i<n; i++){
  8a:	00001497          	auipc	s1,0x1
  8e:	f8648493          	addi	s1,s1,-122 # 1010 <buf>
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
  aa:	ae250513          	addi	a0,a0,-1310 # b88 <malloc+0x10c>
  ae:	00001097          	auipc	ra,0x1
  b2:	916080e7          	jalr	-1770(ra) # 9c4 <printf>
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
  d8:	aa450513          	addi	a0,a0,-1372 # b78 <malloc+0xfc>
  dc:	00001097          	auipc	ra,0x1
  e0:	8e8080e7          	jalr	-1816(ra) # 9c4 <printf>
    exit(1);
  e4:	4505                	li	a0,1
  e6:	00000097          	auipc	ra,0x0
  ea:	55e080e7          	jalr	1374(ra) # 644 <exit>

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
 120:	568080e7          	jalr	1384(ra) # 684 <open>
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
 13c:	534080e7          	jalr	1332(ra) # 66c <close>
  for(i = 1; i < argc; i++){
 140:	0921                	addi	s2,s2,8
 142:	fd391ae3          	bne	s2,s3,116 <main+0x28>
  }
  exit(0);
 146:	4501                	li	a0,0
 148:	00000097          	auipc	ra,0x0
 14c:	4fc080e7          	jalr	1276(ra) # 644 <exit>
    wc(0, "");
 150:	00001597          	auipc	a1,0x1
 154:	a4858593          	addi	a1,a1,-1464 # b98 <malloc+0x11c>
 158:	4501                	li	a0,0
 15a:	00000097          	auipc	ra,0x0
 15e:	ea6080e7          	jalr	-346(ra) # 0 <wc>
    exit(0);
 162:	4501                	li	a0,0
 164:	00000097          	auipc	ra,0x0
 168:	4e0080e7          	jalr	1248(ra) # 644 <exit>
      printf("wc: cannot open %s\n", argv[i]);
 16c:	00093583          	ld	a1,0(s2)
 170:	00001517          	auipc	a0,0x1
 174:	a3050513          	addi	a0,a0,-1488 # ba0 <malloc+0x124>
 178:	00001097          	auipc	ra,0x1
 17c:	84c080e7          	jalr	-1972(ra) # 9c4 <printf>
      exit(1);
 180:	4505                	li	a0,1
 182:	00000097          	auipc	ra,0x0
 186:	4c2080e7          	jalr	1218(ra) # 644 <exit>

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
 1be:	172080e7          	jalr	370(ra) # 32c <twhoami>
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
 20a:	9b250513          	addi	a0,a0,-1614 # bb8 <malloc+0x13c>
 20e:	00000097          	auipc	ra,0x0
 212:	7b6080e7          	jalr	1974(ra) # 9c4 <printf>
        exit(-1);
 216:	557d                	li	a0,-1
 218:	00000097          	auipc	ra,0x0
 21c:	42c080e7          	jalr	1068(ra) # 644 <exit>
    {
        // give up the cpu for other threads
        tyield();
 220:	00000097          	auipc	ra,0x0
 224:	0f4080e7          	jalr	244(ra) # 314 <tyield>
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
 23e:	0f2080e7          	jalr	242(ra) # 32c <twhoami>
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
 282:	096080e7          	jalr	150(ra) # 314 <tyield>
}
 286:	60e2                	ld	ra,24(sp)
 288:	6442                	ld	s0,16(sp)
 28a:	64a2                	ld	s1,8(sp)
 28c:	6105                	addi	sp,sp,32
 28e:	8082                	ret
        printf("releasing lock we are not holding");
 290:	00001517          	auipc	a0,0x1
 294:	95050513          	addi	a0,a0,-1712 # be0 <malloc+0x164>
 298:	00000097          	auipc	ra,0x0
 29c:	72c080e7          	jalr	1836(ra) # 9c4 <printf>
        exit(-1);
 2a0:	557d                	li	a0,-1
 2a2:	00000097          	auipc	ra,0x0
 2a6:	3a2080e7          	jalr	930(ra) # 644 <exit>

00000000000002aa <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
 2aa:	1141                	addi	sp,sp,-16
 2ac:	e422                	sd	s0,8(sp)
 2ae:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 2b0:	00001717          	auipc	a4,0x1
 2b4:	d5073703          	ld	a4,-688(a4) # 1000 <current_thread>
 2b8:	47c1                	li	a5,16
 2ba:	c319                	beqz	a4,2c0 <tsched+0x16>
    for (int i = 0; i < 16; i++) {
 2bc:	37fd                	addiw	a5,a5,-1
 2be:	fff5                	bnez	a5,2ba <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
 2c0:	6422                	ld	s0,8(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret

00000000000002c6 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 2c6:	7179                	addi	sp,sp,-48
 2c8:	f406                	sd	ra,40(sp)
 2ca:	f022                	sd	s0,32(sp)
 2cc:	ec26                	sd	s1,24(sp)
 2ce:	e84a                	sd	s2,16(sp)
 2d0:	e44e                	sd	s3,8(sp)
 2d2:	1800                	addi	s0,sp,48
 2d4:	84aa                	mv	s1,a0
 2d6:	89b2                	mv	s3,a2
 2d8:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 2da:	09000513          	li	a0,144
 2de:	00000097          	auipc	ra,0x0
 2e2:	79e080e7          	jalr	1950(ra) # a7c <malloc>
 2e6:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 2e8:	478d                	li	a5,3
 2ea:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 2ec:	609c                	ld	a5,0(s1)
 2ee:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 2f2:	609c                	ld	a5,0(s1)
 2f4:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
 2f8:	70a2                	ld	ra,40(sp)
 2fa:	7402                	ld	s0,32(sp)
 2fc:	64e2                	ld	s1,24(sp)
 2fe:	6942                	ld	s2,16(sp)
 300:	69a2                	ld	s3,8(sp)
 302:	6145                	addi	sp,sp,48
 304:	8082                	ret

0000000000000306 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 306:	1141                	addi	sp,sp,-16
 308:	e422                	sd	s0,8(sp)
 30a:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
 30c:	4501                	li	a0,0
 30e:	6422                	ld	s0,8(sp)
 310:	0141                	addi	sp,sp,16
 312:	8082                	ret

0000000000000314 <tyield>:

void tyield()
{
 314:	1141                	addi	sp,sp,-16
 316:	e422                	sd	s0,8(sp)
 318:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 31a:	00001797          	auipc	a5,0x1
 31e:	ce67b783          	ld	a5,-794(a5) # 1000 <current_thread>
 322:	470d                	li	a4,3
 324:	dfb8                	sw	a4,120(a5)
    tsched();
}
 326:	6422                	ld	s0,8(sp)
 328:	0141                	addi	sp,sp,16
 32a:	8082                	ret

000000000000032c <twhoami>:

uint8 twhoami()
{
 32c:	1141                	addi	sp,sp,-16
 32e:	e422                	sd	s0,8(sp)
 330:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
 332:	4501                	li	a0,0
 334:	6422                	ld	s0,8(sp)
 336:	0141                	addi	sp,sp,16
 338:	8082                	ret

000000000000033a <tswtch>:
 33a:	00153023          	sd	ra,0(a0)
 33e:	00253423          	sd	sp,8(a0)
 342:	e900                	sd	s0,16(a0)
 344:	ed04                	sd	s1,24(a0)
 346:	03253023          	sd	s2,32(a0)
 34a:	03353423          	sd	s3,40(a0)
 34e:	03453823          	sd	s4,48(a0)
 352:	03553c23          	sd	s5,56(a0)
 356:	05653023          	sd	s6,64(a0)
 35a:	05753423          	sd	s7,72(a0)
 35e:	05853823          	sd	s8,80(a0)
 362:	05953c23          	sd	s9,88(a0)
 366:	07a53023          	sd	s10,96(a0)
 36a:	07b53423          	sd	s11,104(a0)
 36e:	0005b083          	ld	ra,0(a1)
 372:	0085b103          	ld	sp,8(a1)
 376:	6980                	ld	s0,16(a1)
 378:	6d84                	ld	s1,24(a1)
 37a:	0205b903          	ld	s2,32(a1)
 37e:	0285b983          	ld	s3,40(a1)
 382:	0305ba03          	ld	s4,48(a1)
 386:	0385ba83          	ld	s5,56(a1)
 38a:	0405bb03          	ld	s6,64(a1)
 38e:	0485bb83          	ld	s7,72(a1)
 392:	0505bc03          	ld	s8,80(a1)
 396:	0585bc83          	ld	s9,88(a1)
 39a:	0605bd03          	ld	s10,96(a1)
 39e:	0685bd83          	ld	s11,104(a1)
 3a2:	8082                	ret

00000000000003a4 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 3a4:	1101                	addi	sp,sp,-32
 3a6:	ec06                	sd	ra,24(sp)
 3a8:	e822                	sd	s0,16(sp)
 3aa:	e426                	sd	s1,8(sp)
 3ac:	e04a                	sd	s2,0(sp)
 3ae:	1000                	addi	s0,sp,32
 3b0:	84aa                	mv	s1,a0
 3b2:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 3b4:	09000513          	li	a0,144
 3b8:	00000097          	auipc	ra,0x0
 3bc:	6c4080e7          	jalr	1732(ra) # a7c <malloc>

    main_thread->tid = 0;
 3c0:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 3c4:	85ca                	mv	a1,s2
 3c6:	8526                	mv	a0,s1
 3c8:	00000097          	auipc	ra,0x0
 3cc:	d26080e7          	jalr	-730(ra) # ee <main>
    exit(res);
 3d0:	00000097          	auipc	ra,0x0
 3d4:	274080e7          	jalr	628(ra) # 644 <exit>

00000000000003d8 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 3d8:	1141                	addi	sp,sp,-16
 3da:	e422                	sd	s0,8(sp)
 3dc:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 3de:	87aa                	mv	a5,a0
 3e0:	0585                	addi	a1,a1,1
 3e2:	0785                	addi	a5,a5,1
 3e4:	fff5c703          	lbu	a4,-1(a1)
 3e8:	fee78fa3          	sb	a4,-1(a5)
 3ec:	fb75                	bnez	a4,3e0 <strcpy+0x8>
        ;
    return os;
}
 3ee:	6422                	ld	s0,8(sp)
 3f0:	0141                	addi	sp,sp,16
 3f2:	8082                	ret

00000000000003f4 <strcmp>:

int strcmp(const char *p, const char *q)
{
 3f4:	1141                	addi	sp,sp,-16
 3f6:	e422                	sd	s0,8(sp)
 3f8:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 3fa:	00054783          	lbu	a5,0(a0)
 3fe:	cb91                	beqz	a5,412 <strcmp+0x1e>
 400:	0005c703          	lbu	a4,0(a1)
 404:	00f71763          	bne	a4,a5,412 <strcmp+0x1e>
        p++, q++;
 408:	0505                	addi	a0,a0,1
 40a:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 40c:	00054783          	lbu	a5,0(a0)
 410:	fbe5                	bnez	a5,400 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 412:	0005c503          	lbu	a0,0(a1)
}
 416:	40a7853b          	subw	a0,a5,a0
 41a:	6422                	ld	s0,8(sp)
 41c:	0141                	addi	sp,sp,16
 41e:	8082                	ret

0000000000000420 <strlen>:

uint strlen(const char *s)
{
 420:	1141                	addi	sp,sp,-16
 422:	e422                	sd	s0,8(sp)
 424:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 426:	00054783          	lbu	a5,0(a0)
 42a:	cf91                	beqz	a5,446 <strlen+0x26>
 42c:	0505                	addi	a0,a0,1
 42e:	87aa                	mv	a5,a0
 430:	86be                	mv	a3,a5
 432:	0785                	addi	a5,a5,1
 434:	fff7c703          	lbu	a4,-1(a5)
 438:	ff65                	bnez	a4,430 <strlen+0x10>
 43a:	40a6853b          	subw	a0,a3,a0
 43e:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 440:	6422                	ld	s0,8(sp)
 442:	0141                	addi	sp,sp,16
 444:	8082                	ret
    for (n = 0; s[n]; n++)
 446:	4501                	li	a0,0
 448:	bfe5                	j	440 <strlen+0x20>

000000000000044a <memset>:

void *
memset(void *dst, int c, uint n)
{
 44a:	1141                	addi	sp,sp,-16
 44c:	e422                	sd	s0,8(sp)
 44e:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 450:	ca19                	beqz	a2,466 <memset+0x1c>
 452:	87aa                	mv	a5,a0
 454:	1602                	slli	a2,a2,0x20
 456:	9201                	srli	a2,a2,0x20
 458:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 45c:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 460:	0785                	addi	a5,a5,1
 462:	fee79de3          	bne	a5,a4,45c <memset+0x12>
    }
    return dst;
}
 466:	6422                	ld	s0,8(sp)
 468:	0141                	addi	sp,sp,16
 46a:	8082                	ret

000000000000046c <strchr>:

char *
strchr(const char *s, char c)
{
 46c:	1141                	addi	sp,sp,-16
 46e:	e422                	sd	s0,8(sp)
 470:	0800                	addi	s0,sp,16
    for (; *s; s++)
 472:	00054783          	lbu	a5,0(a0)
 476:	cb99                	beqz	a5,48c <strchr+0x20>
        if (*s == c)
 478:	00f58763          	beq	a1,a5,486 <strchr+0x1a>
    for (; *s; s++)
 47c:	0505                	addi	a0,a0,1
 47e:	00054783          	lbu	a5,0(a0)
 482:	fbfd                	bnez	a5,478 <strchr+0xc>
            return (char *)s;
    return 0;
 484:	4501                	li	a0,0
}
 486:	6422                	ld	s0,8(sp)
 488:	0141                	addi	sp,sp,16
 48a:	8082                	ret
    return 0;
 48c:	4501                	li	a0,0
 48e:	bfe5                	j	486 <strchr+0x1a>

0000000000000490 <gets>:

char *
gets(char *buf, int max)
{
 490:	711d                	addi	sp,sp,-96
 492:	ec86                	sd	ra,88(sp)
 494:	e8a2                	sd	s0,80(sp)
 496:	e4a6                	sd	s1,72(sp)
 498:	e0ca                	sd	s2,64(sp)
 49a:	fc4e                	sd	s3,56(sp)
 49c:	f852                	sd	s4,48(sp)
 49e:	f456                	sd	s5,40(sp)
 4a0:	f05a                	sd	s6,32(sp)
 4a2:	ec5e                	sd	s7,24(sp)
 4a4:	1080                	addi	s0,sp,96
 4a6:	8baa                	mv	s7,a0
 4a8:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 4aa:	892a                	mv	s2,a0
 4ac:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 4ae:	4aa9                	li	s5,10
 4b0:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 4b2:	89a6                	mv	s3,s1
 4b4:	2485                	addiw	s1,s1,1
 4b6:	0344d863          	bge	s1,s4,4e6 <gets+0x56>
        cc = read(0, &c, 1);
 4ba:	4605                	li	a2,1
 4bc:	faf40593          	addi	a1,s0,-81
 4c0:	4501                	li	a0,0
 4c2:	00000097          	auipc	ra,0x0
 4c6:	19a080e7          	jalr	410(ra) # 65c <read>
        if (cc < 1)
 4ca:	00a05e63          	blez	a0,4e6 <gets+0x56>
        buf[i++] = c;
 4ce:	faf44783          	lbu	a5,-81(s0)
 4d2:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 4d6:	01578763          	beq	a5,s5,4e4 <gets+0x54>
 4da:	0905                	addi	s2,s2,1
 4dc:	fd679be3          	bne	a5,s6,4b2 <gets+0x22>
    for (i = 0; i + 1 < max;)
 4e0:	89a6                	mv	s3,s1
 4e2:	a011                	j	4e6 <gets+0x56>
 4e4:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 4e6:	99de                	add	s3,s3,s7
 4e8:	00098023          	sb	zero,0(s3)
    return buf;
}
 4ec:	855e                	mv	a0,s7
 4ee:	60e6                	ld	ra,88(sp)
 4f0:	6446                	ld	s0,80(sp)
 4f2:	64a6                	ld	s1,72(sp)
 4f4:	6906                	ld	s2,64(sp)
 4f6:	79e2                	ld	s3,56(sp)
 4f8:	7a42                	ld	s4,48(sp)
 4fa:	7aa2                	ld	s5,40(sp)
 4fc:	7b02                	ld	s6,32(sp)
 4fe:	6be2                	ld	s7,24(sp)
 500:	6125                	addi	sp,sp,96
 502:	8082                	ret

0000000000000504 <stat>:

int stat(const char *n, struct stat *st)
{
 504:	1101                	addi	sp,sp,-32
 506:	ec06                	sd	ra,24(sp)
 508:	e822                	sd	s0,16(sp)
 50a:	e426                	sd	s1,8(sp)
 50c:	e04a                	sd	s2,0(sp)
 50e:	1000                	addi	s0,sp,32
 510:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 512:	4581                	li	a1,0
 514:	00000097          	auipc	ra,0x0
 518:	170080e7          	jalr	368(ra) # 684 <open>
    if (fd < 0)
 51c:	02054563          	bltz	a0,546 <stat+0x42>
 520:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 522:	85ca                	mv	a1,s2
 524:	00000097          	auipc	ra,0x0
 528:	178080e7          	jalr	376(ra) # 69c <fstat>
 52c:	892a                	mv	s2,a0
    close(fd);
 52e:	8526                	mv	a0,s1
 530:	00000097          	auipc	ra,0x0
 534:	13c080e7          	jalr	316(ra) # 66c <close>
    return r;
}
 538:	854a                	mv	a0,s2
 53a:	60e2                	ld	ra,24(sp)
 53c:	6442                	ld	s0,16(sp)
 53e:	64a2                	ld	s1,8(sp)
 540:	6902                	ld	s2,0(sp)
 542:	6105                	addi	sp,sp,32
 544:	8082                	ret
        return -1;
 546:	597d                	li	s2,-1
 548:	bfc5                	j	538 <stat+0x34>

000000000000054a <atoi>:

int atoi(const char *s)
{
 54a:	1141                	addi	sp,sp,-16
 54c:	e422                	sd	s0,8(sp)
 54e:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 550:	00054683          	lbu	a3,0(a0)
 554:	fd06879b          	addiw	a5,a3,-48
 558:	0ff7f793          	zext.b	a5,a5
 55c:	4625                	li	a2,9
 55e:	02f66863          	bltu	a2,a5,58e <atoi+0x44>
 562:	872a                	mv	a4,a0
    n = 0;
 564:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 566:	0705                	addi	a4,a4,1
 568:	0025179b          	slliw	a5,a0,0x2
 56c:	9fa9                	addw	a5,a5,a0
 56e:	0017979b          	slliw	a5,a5,0x1
 572:	9fb5                	addw	a5,a5,a3
 574:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 578:	00074683          	lbu	a3,0(a4)
 57c:	fd06879b          	addiw	a5,a3,-48
 580:	0ff7f793          	zext.b	a5,a5
 584:	fef671e3          	bgeu	a2,a5,566 <atoi+0x1c>
    return n;
}
 588:	6422                	ld	s0,8(sp)
 58a:	0141                	addi	sp,sp,16
 58c:	8082                	ret
    n = 0;
 58e:	4501                	li	a0,0
 590:	bfe5                	j	588 <atoi+0x3e>

0000000000000592 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 592:	1141                	addi	sp,sp,-16
 594:	e422                	sd	s0,8(sp)
 596:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 598:	02b57463          	bgeu	a0,a1,5c0 <memmove+0x2e>
    {
        while (n-- > 0)
 59c:	00c05f63          	blez	a2,5ba <memmove+0x28>
 5a0:	1602                	slli	a2,a2,0x20
 5a2:	9201                	srli	a2,a2,0x20
 5a4:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 5a8:	872a                	mv	a4,a0
            *dst++ = *src++;
 5aa:	0585                	addi	a1,a1,1
 5ac:	0705                	addi	a4,a4,1
 5ae:	fff5c683          	lbu	a3,-1(a1)
 5b2:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 5b6:	fee79ae3          	bne	a5,a4,5aa <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 5ba:	6422                	ld	s0,8(sp)
 5bc:	0141                	addi	sp,sp,16
 5be:	8082                	ret
        dst += n;
 5c0:	00c50733          	add	a4,a0,a2
        src += n;
 5c4:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 5c6:	fec05ae3          	blez	a2,5ba <memmove+0x28>
 5ca:	fff6079b          	addiw	a5,a2,-1
 5ce:	1782                	slli	a5,a5,0x20
 5d0:	9381                	srli	a5,a5,0x20
 5d2:	fff7c793          	not	a5,a5
 5d6:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 5d8:	15fd                	addi	a1,a1,-1
 5da:	177d                	addi	a4,a4,-1
 5dc:	0005c683          	lbu	a3,0(a1)
 5e0:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 5e4:	fee79ae3          	bne	a5,a4,5d8 <memmove+0x46>
 5e8:	bfc9                	j	5ba <memmove+0x28>

00000000000005ea <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 5ea:	1141                	addi	sp,sp,-16
 5ec:	e422                	sd	s0,8(sp)
 5ee:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 5f0:	ca05                	beqz	a2,620 <memcmp+0x36>
 5f2:	fff6069b          	addiw	a3,a2,-1
 5f6:	1682                	slli	a3,a3,0x20
 5f8:	9281                	srli	a3,a3,0x20
 5fa:	0685                	addi	a3,a3,1
 5fc:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 5fe:	00054783          	lbu	a5,0(a0)
 602:	0005c703          	lbu	a4,0(a1)
 606:	00e79863          	bne	a5,a4,616 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 60a:	0505                	addi	a0,a0,1
        p2++;
 60c:	0585                	addi	a1,a1,1
    while (n-- > 0)
 60e:	fed518e3          	bne	a0,a3,5fe <memcmp+0x14>
    }
    return 0;
 612:	4501                	li	a0,0
 614:	a019                	j	61a <memcmp+0x30>
            return *p1 - *p2;
 616:	40e7853b          	subw	a0,a5,a4
}
 61a:	6422                	ld	s0,8(sp)
 61c:	0141                	addi	sp,sp,16
 61e:	8082                	ret
    return 0;
 620:	4501                	li	a0,0
 622:	bfe5                	j	61a <memcmp+0x30>

0000000000000624 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 624:	1141                	addi	sp,sp,-16
 626:	e406                	sd	ra,8(sp)
 628:	e022                	sd	s0,0(sp)
 62a:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 62c:	00000097          	auipc	ra,0x0
 630:	f66080e7          	jalr	-154(ra) # 592 <memmove>
}
 634:	60a2                	ld	ra,8(sp)
 636:	6402                	ld	s0,0(sp)
 638:	0141                	addi	sp,sp,16
 63a:	8082                	ret

000000000000063c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 63c:	4885                	li	a7,1
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <exit>:
.global exit
exit:
 li a7, SYS_exit
 644:	4889                	li	a7,2
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <wait>:
.global wait
wait:
 li a7, SYS_wait
 64c:	488d                	li	a7,3
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 654:	4891                	li	a7,4
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <read>:
.global read
read:
 li a7, SYS_read
 65c:	4895                	li	a7,5
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <write>:
.global write
write:
 li a7, SYS_write
 664:	48c1                	li	a7,16
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <close>:
.global close
close:
 li a7, SYS_close
 66c:	48d5                	li	a7,21
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <kill>:
.global kill
kill:
 li a7, SYS_kill
 674:	4899                	li	a7,6
 ecall
 676:	00000073          	ecall
 ret
 67a:	8082                	ret

000000000000067c <exec>:
.global exec
exec:
 li a7, SYS_exec
 67c:	489d                	li	a7,7
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <open>:
.global open
open:
 li a7, SYS_open
 684:	48bd                	li	a7,15
 ecall
 686:	00000073          	ecall
 ret
 68a:	8082                	ret

000000000000068c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 68c:	48c5                	li	a7,17
 ecall
 68e:	00000073          	ecall
 ret
 692:	8082                	ret

0000000000000694 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 694:	48c9                	li	a7,18
 ecall
 696:	00000073          	ecall
 ret
 69a:	8082                	ret

000000000000069c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 69c:	48a1                	li	a7,8
 ecall
 69e:	00000073          	ecall
 ret
 6a2:	8082                	ret

00000000000006a4 <link>:
.global link
link:
 li a7, SYS_link
 6a4:	48cd                	li	a7,19
 ecall
 6a6:	00000073          	ecall
 ret
 6aa:	8082                	ret

00000000000006ac <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6ac:	48d1                	li	a7,20
 ecall
 6ae:	00000073          	ecall
 ret
 6b2:	8082                	ret

00000000000006b4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6b4:	48a5                	li	a7,9
 ecall
 6b6:	00000073          	ecall
 ret
 6ba:	8082                	ret

00000000000006bc <dup>:
.global dup
dup:
 li a7, SYS_dup
 6bc:	48a9                	li	a7,10
 ecall
 6be:	00000073          	ecall
 ret
 6c2:	8082                	ret

00000000000006c4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6c4:	48ad                	li	a7,11
 ecall
 6c6:	00000073          	ecall
 ret
 6ca:	8082                	ret

00000000000006cc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6cc:	48b1                	li	a7,12
 ecall
 6ce:	00000073          	ecall
 ret
 6d2:	8082                	ret

00000000000006d4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6d4:	48b5                	li	a7,13
 ecall
 6d6:	00000073          	ecall
 ret
 6da:	8082                	ret

00000000000006dc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6dc:	48b9                	li	a7,14
 ecall
 6de:	00000073          	ecall
 ret
 6e2:	8082                	ret

00000000000006e4 <ps>:
.global ps
ps:
 li a7, SYS_ps
 6e4:	48d9                	li	a7,22
 ecall
 6e6:	00000073          	ecall
 ret
 6ea:	8082                	ret

00000000000006ec <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 6ec:	48dd                	li	a7,23
 ecall
 6ee:	00000073          	ecall
 ret
 6f2:	8082                	ret

00000000000006f4 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 6f4:	48e1                	li	a7,24
 ecall
 6f6:	00000073          	ecall
 ret
 6fa:	8082                	ret

00000000000006fc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6fc:	1101                	addi	sp,sp,-32
 6fe:	ec06                	sd	ra,24(sp)
 700:	e822                	sd	s0,16(sp)
 702:	1000                	addi	s0,sp,32
 704:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 708:	4605                	li	a2,1
 70a:	fef40593          	addi	a1,s0,-17
 70e:	00000097          	auipc	ra,0x0
 712:	f56080e7          	jalr	-170(ra) # 664 <write>
}
 716:	60e2                	ld	ra,24(sp)
 718:	6442                	ld	s0,16(sp)
 71a:	6105                	addi	sp,sp,32
 71c:	8082                	ret

000000000000071e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 71e:	7139                	addi	sp,sp,-64
 720:	fc06                	sd	ra,56(sp)
 722:	f822                	sd	s0,48(sp)
 724:	f426                	sd	s1,40(sp)
 726:	f04a                	sd	s2,32(sp)
 728:	ec4e                	sd	s3,24(sp)
 72a:	0080                	addi	s0,sp,64
 72c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 72e:	c299                	beqz	a3,734 <printint+0x16>
 730:	0805c963          	bltz	a1,7c2 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 734:	2581                	sext.w	a1,a1
  neg = 0;
 736:	4881                	li	a7,0
 738:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 73c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 73e:	2601                	sext.w	a2,a2
 740:	00000517          	auipc	a0,0x0
 744:	52850513          	addi	a0,a0,1320 # c68 <digits>
 748:	883a                	mv	a6,a4
 74a:	2705                	addiw	a4,a4,1
 74c:	02c5f7bb          	remuw	a5,a1,a2
 750:	1782                	slli	a5,a5,0x20
 752:	9381                	srli	a5,a5,0x20
 754:	97aa                	add	a5,a5,a0
 756:	0007c783          	lbu	a5,0(a5)
 75a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 75e:	0005879b          	sext.w	a5,a1
 762:	02c5d5bb          	divuw	a1,a1,a2
 766:	0685                	addi	a3,a3,1
 768:	fec7f0e3          	bgeu	a5,a2,748 <printint+0x2a>
  if(neg)
 76c:	00088c63          	beqz	a7,784 <printint+0x66>
    buf[i++] = '-';
 770:	fd070793          	addi	a5,a4,-48
 774:	00878733          	add	a4,a5,s0
 778:	02d00793          	li	a5,45
 77c:	fef70823          	sb	a5,-16(a4)
 780:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 784:	02e05863          	blez	a4,7b4 <printint+0x96>
 788:	fc040793          	addi	a5,s0,-64
 78c:	00e78933          	add	s2,a5,a4
 790:	fff78993          	addi	s3,a5,-1
 794:	99ba                	add	s3,s3,a4
 796:	377d                	addiw	a4,a4,-1
 798:	1702                	slli	a4,a4,0x20
 79a:	9301                	srli	a4,a4,0x20
 79c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7a0:	fff94583          	lbu	a1,-1(s2)
 7a4:	8526                	mv	a0,s1
 7a6:	00000097          	auipc	ra,0x0
 7aa:	f56080e7          	jalr	-170(ra) # 6fc <putc>
  while(--i >= 0)
 7ae:	197d                	addi	s2,s2,-1
 7b0:	ff3918e3          	bne	s2,s3,7a0 <printint+0x82>
}
 7b4:	70e2                	ld	ra,56(sp)
 7b6:	7442                	ld	s0,48(sp)
 7b8:	74a2                	ld	s1,40(sp)
 7ba:	7902                	ld	s2,32(sp)
 7bc:	69e2                	ld	s3,24(sp)
 7be:	6121                	addi	sp,sp,64
 7c0:	8082                	ret
    x = -xx;
 7c2:	40b005bb          	negw	a1,a1
    neg = 1;
 7c6:	4885                	li	a7,1
    x = -xx;
 7c8:	bf85                	j	738 <printint+0x1a>

00000000000007ca <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7ca:	715d                	addi	sp,sp,-80
 7cc:	e486                	sd	ra,72(sp)
 7ce:	e0a2                	sd	s0,64(sp)
 7d0:	fc26                	sd	s1,56(sp)
 7d2:	f84a                	sd	s2,48(sp)
 7d4:	f44e                	sd	s3,40(sp)
 7d6:	f052                	sd	s4,32(sp)
 7d8:	ec56                	sd	s5,24(sp)
 7da:	e85a                	sd	s6,16(sp)
 7dc:	e45e                	sd	s7,8(sp)
 7de:	e062                	sd	s8,0(sp)
 7e0:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7e2:	0005c903          	lbu	s2,0(a1)
 7e6:	18090c63          	beqz	s2,97e <vprintf+0x1b4>
 7ea:	8aaa                	mv	s5,a0
 7ec:	8bb2                	mv	s7,a2
 7ee:	00158493          	addi	s1,a1,1
  state = 0;
 7f2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 7f4:	02500a13          	li	s4,37
 7f8:	4b55                	li	s6,21
 7fa:	a839                	j	818 <vprintf+0x4e>
        putc(fd, c);
 7fc:	85ca                	mv	a1,s2
 7fe:	8556                	mv	a0,s5
 800:	00000097          	auipc	ra,0x0
 804:	efc080e7          	jalr	-260(ra) # 6fc <putc>
 808:	a019                	j	80e <vprintf+0x44>
    } else if(state == '%'){
 80a:	01498d63          	beq	s3,s4,824 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 80e:	0485                	addi	s1,s1,1
 810:	fff4c903          	lbu	s2,-1(s1)
 814:	16090563          	beqz	s2,97e <vprintf+0x1b4>
    if(state == 0){
 818:	fe0999e3          	bnez	s3,80a <vprintf+0x40>
      if(c == '%'){
 81c:	ff4910e3          	bne	s2,s4,7fc <vprintf+0x32>
        state = '%';
 820:	89d2                	mv	s3,s4
 822:	b7f5                	j	80e <vprintf+0x44>
      if(c == 'd'){
 824:	13490263          	beq	s2,s4,948 <vprintf+0x17e>
 828:	f9d9079b          	addiw	a5,s2,-99
 82c:	0ff7f793          	zext.b	a5,a5
 830:	12fb6563          	bltu	s6,a5,95a <vprintf+0x190>
 834:	f9d9079b          	addiw	a5,s2,-99
 838:	0ff7f713          	zext.b	a4,a5
 83c:	10eb6f63          	bltu	s6,a4,95a <vprintf+0x190>
 840:	00271793          	slli	a5,a4,0x2
 844:	00000717          	auipc	a4,0x0
 848:	3cc70713          	addi	a4,a4,972 # c10 <malloc+0x194>
 84c:	97ba                	add	a5,a5,a4
 84e:	439c                	lw	a5,0(a5)
 850:	97ba                	add	a5,a5,a4
 852:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 854:	008b8913          	addi	s2,s7,8
 858:	4685                	li	a3,1
 85a:	4629                	li	a2,10
 85c:	000ba583          	lw	a1,0(s7)
 860:	8556                	mv	a0,s5
 862:	00000097          	auipc	ra,0x0
 866:	ebc080e7          	jalr	-324(ra) # 71e <printint>
 86a:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 86c:	4981                	li	s3,0
 86e:	b745                	j	80e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 870:	008b8913          	addi	s2,s7,8
 874:	4681                	li	a3,0
 876:	4629                	li	a2,10
 878:	000ba583          	lw	a1,0(s7)
 87c:	8556                	mv	a0,s5
 87e:	00000097          	auipc	ra,0x0
 882:	ea0080e7          	jalr	-352(ra) # 71e <printint>
 886:	8bca                	mv	s7,s2
      state = 0;
 888:	4981                	li	s3,0
 88a:	b751                	j	80e <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 88c:	008b8913          	addi	s2,s7,8
 890:	4681                	li	a3,0
 892:	4641                	li	a2,16
 894:	000ba583          	lw	a1,0(s7)
 898:	8556                	mv	a0,s5
 89a:	00000097          	auipc	ra,0x0
 89e:	e84080e7          	jalr	-380(ra) # 71e <printint>
 8a2:	8bca                	mv	s7,s2
      state = 0;
 8a4:	4981                	li	s3,0
 8a6:	b7a5                	j	80e <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 8a8:	008b8c13          	addi	s8,s7,8
 8ac:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 8b0:	03000593          	li	a1,48
 8b4:	8556                	mv	a0,s5
 8b6:	00000097          	auipc	ra,0x0
 8ba:	e46080e7          	jalr	-442(ra) # 6fc <putc>
  putc(fd, 'x');
 8be:	07800593          	li	a1,120
 8c2:	8556                	mv	a0,s5
 8c4:	00000097          	auipc	ra,0x0
 8c8:	e38080e7          	jalr	-456(ra) # 6fc <putc>
 8cc:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8ce:	00000b97          	auipc	s7,0x0
 8d2:	39ab8b93          	addi	s7,s7,922 # c68 <digits>
 8d6:	03c9d793          	srli	a5,s3,0x3c
 8da:	97de                	add	a5,a5,s7
 8dc:	0007c583          	lbu	a1,0(a5)
 8e0:	8556                	mv	a0,s5
 8e2:	00000097          	auipc	ra,0x0
 8e6:	e1a080e7          	jalr	-486(ra) # 6fc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8ea:	0992                	slli	s3,s3,0x4
 8ec:	397d                	addiw	s2,s2,-1
 8ee:	fe0914e3          	bnez	s2,8d6 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 8f2:	8be2                	mv	s7,s8
      state = 0;
 8f4:	4981                	li	s3,0
 8f6:	bf21                	j	80e <vprintf+0x44>
        s = va_arg(ap, char*);
 8f8:	008b8993          	addi	s3,s7,8
 8fc:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 900:	02090163          	beqz	s2,922 <vprintf+0x158>
        while(*s != 0){
 904:	00094583          	lbu	a1,0(s2)
 908:	c9a5                	beqz	a1,978 <vprintf+0x1ae>
          putc(fd, *s);
 90a:	8556                	mv	a0,s5
 90c:	00000097          	auipc	ra,0x0
 910:	df0080e7          	jalr	-528(ra) # 6fc <putc>
          s++;
 914:	0905                	addi	s2,s2,1
        while(*s != 0){
 916:	00094583          	lbu	a1,0(s2)
 91a:	f9e5                	bnez	a1,90a <vprintf+0x140>
        s = va_arg(ap, char*);
 91c:	8bce                	mv	s7,s3
      state = 0;
 91e:	4981                	li	s3,0
 920:	b5fd                	j	80e <vprintf+0x44>
          s = "(null)";
 922:	00000917          	auipc	s2,0x0
 926:	2e690913          	addi	s2,s2,742 # c08 <malloc+0x18c>
        while(*s != 0){
 92a:	02800593          	li	a1,40
 92e:	bff1                	j	90a <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 930:	008b8913          	addi	s2,s7,8
 934:	000bc583          	lbu	a1,0(s7)
 938:	8556                	mv	a0,s5
 93a:	00000097          	auipc	ra,0x0
 93e:	dc2080e7          	jalr	-574(ra) # 6fc <putc>
 942:	8bca                	mv	s7,s2
      state = 0;
 944:	4981                	li	s3,0
 946:	b5e1                	j	80e <vprintf+0x44>
        putc(fd, c);
 948:	02500593          	li	a1,37
 94c:	8556                	mv	a0,s5
 94e:	00000097          	auipc	ra,0x0
 952:	dae080e7          	jalr	-594(ra) # 6fc <putc>
      state = 0;
 956:	4981                	li	s3,0
 958:	bd5d                	j	80e <vprintf+0x44>
        putc(fd, '%');
 95a:	02500593          	li	a1,37
 95e:	8556                	mv	a0,s5
 960:	00000097          	auipc	ra,0x0
 964:	d9c080e7          	jalr	-612(ra) # 6fc <putc>
        putc(fd, c);
 968:	85ca                	mv	a1,s2
 96a:	8556                	mv	a0,s5
 96c:	00000097          	auipc	ra,0x0
 970:	d90080e7          	jalr	-624(ra) # 6fc <putc>
      state = 0;
 974:	4981                	li	s3,0
 976:	bd61                	j	80e <vprintf+0x44>
        s = va_arg(ap, char*);
 978:	8bce                	mv	s7,s3
      state = 0;
 97a:	4981                	li	s3,0
 97c:	bd49                	j	80e <vprintf+0x44>
    }
  }
}
 97e:	60a6                	ld	ra,72(sp)
 980:	6406                	ld	s0,64(sp)
 982:	74e2                	ld	s1,56(sp)
 984:	7942                	ld	s2,48(sp)
 986:	79a2                	ld	s3,40(sp)
 988:	7a02                	ld	s4,32(sp)
 98a:	6ae2                	ld	s5,24(sp)
 98c:	6b42                	ld	s6,16(sp)
 98e:	6ba2                	ld	s7,8(sp)
 990:	6c02                	ld	s8,0(sp)
 992:	6161                	addi	sp,sp,80
 994:	8082                	ret

0000000000000996 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 996:	715d                	addi	sp,sp,-80
 998:	ec06                	sd	ra,24(sp)
 99a:	e822                	sd	s0,16(sp)
 99c:	1000                	addi	s0,sp,32
 99e:	e010                	sd	a2,0(s0)
 9a0:	e414                	sd	a3,8(s0)
 9a2:	e818                	sd	a4,16(s0)
 9a4:	ec1c                	sd	a5,24(s0)
 9a6:	03043023          	sd	a6,32(s0)
 9aa:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9ae:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9b2:	8622                	mv	a2,s0
 9b4:	00000097          	auipc	ra,0x0
 9b8:	e16080e7          	jalr	-490(ra) # 7ca <vprintf>
}
 9bc:	60e2                	ld	ra,24(sp)
 9be:	6442                	ld	s0,16(sp)
 9c0:	6161                	addi	sp,sp,80
 9c2:	8082                	ret

00000000000009c4 <printf>:

void
printf(const char *fmt, ...)
{
 9c4:	711d                	addi	sp,sp,-96
 9c6:	ec06                	sd	ra,24(sp)
 9c8:	e822                	sd	s0,16(sp)
 9ca:	1000                	addi	s0,sp,32
 9cc:	e40c                	sd	a1,8(s0)
 9ce:	e810                	sd	a2,16(s0)
 9d0:	ec14                	sd	a3,24(s0)
 9d2:	f018                	sd	a4,32(s0)
 9d4:	f41c                	sd	a5,40(s0)
 9d6:	03043823          	sd	a6,48(s0)
 9da:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9de:	00840613          	addi	a2,s0,8
 9e2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9e6:	85aa                	mv	a1,a0
 9e8:	4505                	li	a0,1
 9ea:	00000097          	auipc	ra,0x0
 9ee:	de0080e7          	jalr	-544(ra) # 7ca <vprintf>
}
 9f2:	60e2                	ld	ra,24(sp)
 9f4:	6442                	ld	s0,16(sp)
 9f6:	6125                	addi	sp,sp,96
 9f8:	8082                	ret

00000000000009fa <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 9fa:	1141                	addi	sp,sp,-16
 9fc:	e422                	sd	s0,8(sp)
 9fe:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 a00:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a04:	00000797          	auipc	a5,0x0
 a08:	6047b783          	ld	a5,1540(a5) # 1008 <freep>
 a0c:	a02d                	j	a36 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 a0e:	4618                	lw	a4,8(a2)
 a10:	9f2d                	addw	a4,a4,a1
 a12:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 a16:	6398                	ld	a4,0(a5)
 a18:	6310                	ld	a2,0(a4)
 a1a:	a83d                	j	a58 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 a1c:	ff852703          	lw	a4,-8(a0)
 a20:	9f31                	addw	a4,a4,a2
 a22:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 a24:	ff053683          	ld	a3,-16(a0)
 a28:	a091                	j	a6c <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a2a:	6398                	ld	a4,0(a5)
 a2c:	00e7e463          	bltu	a5,a4,a34 <free+0x3a>
 a30:	00e6ea63          	bltu	a3,a4,a44 <free+0x4a>
{
 a34:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a36:	fed7fae3          	bgeu	a5,a3,a2a <free+0x30>
 a3a:	6398                	ld	a4,0(a5)
 a3c:	00e6e463          	bltu	a3,a4,a44 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a40:	fee7eae3          	bltu	a5,a4,a34 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 a44:	ff852583          	lw	a1,-8(a0)
 a48:	6390                	ld	a2,0(a5)
 a4a:	02059813          	slli	a6,a1,0x20
 a4e:	01c85713          	srli	a4,a6,0x1c
 a52:	9736                	add	a4,a4,a3
 a54:	fae60de3          	beq	a2,a4,a0e <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 a58:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 a5c:	4790                	lw	a2,8(a5)
 a5e:	02061593          	slli	a1,a2,0x20
 a62:	01c5d713          	srli	a4,a1,0x1c
 a66:	973e                	add	a4,a4,a5
 a68:	fae68ae3          	beq	a3,a4,a1c <free+0x22>
        p->s.ptr = bp->s.ptr;
 a6c:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 a6e:	00000717          	auipc	a4,0x0
 a72:	58f73d23          	sd	a5,1434(a4) # 1008 <freep>
}
 a76:	6422                	ld	s0,8(sp)
 a78:	0141                	addi	sp,sp,16
 a7a:	8082                	ret

0000000000000a7c <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 a7c:	7139                	addi	sp,sp,-64
 a7e:	fc06                	sd	ra,56(sp)
 a80:	f822                	sd	s0,48(sp)
 a82:	f426                	sd	s1,40(sp)
 a84:	f04a                	sd	s2,32(sp)
 a86:	ec4e                	sd	s3,24(sp)
 a88:	e852                	sd	s4,16(sp)
 a8a:	e456                	sd	s5,8(sp)
 a8c:	e05a                	sd	s6,0(sp)
 a8e:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 a90:	02051493          	slli	s1,a0,0x20
 a94:	9081                	srli	s1,s1,0x20
 a96:	04bd                	addi	s1,s1,15
 a98:	8091                	srli	s1,s1,0x4
 a9a:	0014899b          	addiw	s3,s1,1
 a9e:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 aa0:	00000517          	auipc	a0,0x0
 aa4:	56853503          	ld	a0,1384(a0) # 1008 <freep>
 aa8:	c515                	beqz	a0,ad4 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 aaa:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 aac:	4798                	lw	a4,8(a5)
 aae:	02977f63          	bgeu	a4,s1,aec <malloc+0x70>
    if (nu < 4096)
 ab2:	8a4e                	mv	s4,s3
 ab4:	0009871b          	sext.w	a4,s3
 ab8:	6685                	lui	a3,0x1
 aba:	00d77363          	bgeu	a4,a3,ac0 <malloc+0x44>
 abe:	6a05                	lui	s4,0x1
 ac0:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 ac4:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 ac8:	00000917          	auipc	s2,0x0
 acc:	54090913          	addi	s2,s2,1344 # 1008 <freep>
    if (p == (char *)-1)
 ad0:	5afd                	li	s5,-1
 ad2:	a895                	j	b46 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 ad4:	00000797          	auipc	a5,0x0
 ad8:	73c78793          	addi	a5,a5,1852 # 1210 <base>
 adc:	00000717          	auipc	a4,0x0
 ae0:	52f73623          	sd	a5,1324(a4) # 1008 <freep>
 ae4:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 ae6:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 aea:	b7e1                	j	ab2 <malloc+0x36>
            if (p->s.size == nunits)
 aec:	02e48c63          	beq	s1,a4,b24 <malloc+0xa8>
                p->s.size -= nunits;
 af0:	4137073b          	subw	a4,a4,s3
 af4:	c798                	sw	a4,8(a5)
                p += p->s.size;
 af6:	02071693          	slli	a3,a4,0x20
 afa:	01c6d713          	srli	a4,a3,0x1c
 afe:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 b00:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 b04:	00000717          	auipc	a4,0x0
 b08:	50a73223          	sd	a0,1284(a4) # 1008 <freep>
            return (void *)(p + 1);
 b0c:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 b10:	70e2                	ld	ra,56(sp)
 b12:	7442                	ld	s0,48(sp)
 b14:	74a2                	ld	s1,40(sp)
 b16:	7902                	ld	s2,32(sp)
 b18:	69e2                	ld	s3,24(sp)
 b1a:	6a42                	ld	s4,16(sp)
 b1c:	6aa2                	ld	s5,8(sp)
 b1e:	6b02                	ld	s6,0(sp)
 b20:	6121                	addi	sp,sp,64
 b22:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 b24:	6398                	ld	a4,0(a5)
 b26:	e118                	sd	a4,0(a0)
 b28:	bff1                	j	b04 <malloc+0x88>
    hp->s.size = nu;
 b2a:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 b2e:	0541                	addi	a0,a0,16
 b30:	00000097          	auipc	ra,0x0
 b34:	eca080e7          	jalr	-310(ra) # 9fa <free>
    return freep;
 b38:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 b3c:	d971                	beqz	a0,b10 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b3e:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 b40:	4798                	lw	a4,8(a5)
 b42:	fa9775e3          	bgeu	a4,s1,aec <malloc+0x70>
        if (p == freep)
 b46:	00093703          	ld	a4,0(s2)
 b4a:	853e                	mv	a0,a5
 b4c:	fef719e3          	bne	a4,a5,b3e <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 b50:	8552                	mv	a0,s4
 b52:	00000097          	auipc	ra,0x0
 b56:	b7a080e7          	jalr	-1158(ra) # 6cc <sbrk>
    if (p == (char *)-1)
 b5a:	fd5518e3          	bne	a0,s5,b2a <malloc+0xae>
                return 0;
 b5e:	4501                	li	a0,0
 b60:	bf45                	j	b10 <malloc+0x94>
