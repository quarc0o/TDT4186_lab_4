
user/_rm:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
   c:	4785                	li	a5,1
   e:	02a7d763          	bge	a5,a0,3c <main+0x3c>
  12:	00858493          	addi	s1,a1,8
  16:	ffe5091b          	addiw	s2,a0,-2
  1a:	02091793          	slli	a5,s2,0x20
  1e:	01d7d913          	srli	s2,a5,0x1d
  22:	05c1                	addi	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "Usage: rm files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
  26:	6088                	ld	a0,0(s1)
  28:	00000097          	auipc	ra,0x0
  2c:	558080e7          	jalr	1368(ra) # 580 <unlink>
  30:	02054463          	bltz	a0,58 <main+0x58>
  for(i = 1; i < argc; i++){
  34:	04a1                	addi	s1,s1,8
  36:	ff2498e3          	bne	s1,s2,26 <main+0x26>
  3a:	a80d                	j	6c <main+0x6c>
    fprintf(2, "Usage: rm files...\n");
  3c:	00001597          	auipc	a1,0x1
  40:	a1458593          	addi	a1,a1,-1516 # a50 <malloc+0xe8>
  44:	4509                	li	a0,2
  46:	00001097          	auipc	ra,0x1
  4a:	83c080e7          	jalr	-1988(ra) # 882 <fprintf>
    exit(1);
  4e:	4505                	li	a0,1
  50:	00000097          	auipc	ra,0x0
  54:	4e0080e7          	jalr	1248(ra) # 530 <exit>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
  58:	6090                	ld	a2,0(s1)
  5a:	00001597          	auipc	a1,0x1
  5e:	a0e58593          	addi	a1,a1,-1522 # a68 <malloc+0x100>
  62:	4509                	li	a0,2
  64:	00001097          	auipc	ra,0x1
  68:	81e080e7          	jalr	-2018(ra) # 882 <fprintf>
      break;
    }
  }

  exit(0);
  6c:	4501                	li	a0,0
  6e:	00000097          	auipc	ra,0x0
  72:	4c2080e7          	jalr	1218(ra) # 530 <exit>

0000000000000076 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  76:	1141                	addi	sp,sp,-16
  78:	e422                	sd	s0,8(sp)
  7a:	0800                	addi	s0,sp,16
    lk->name = name;
  7c:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  7e:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  82:	57fd                	li	a5,-1
  84:	00f50823          	sb	a5,16(a0)
}
  88:	6422                	ld	s0,8(sp)
  8a:	0141                	addi	sp,sp,16
  8c:	8082                	ret

000000000000008e <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  8e:	00054783          	lbu	a5,0(a0)
  92:	e399                	bnez	a5,98 <holding+0xa>
  94:	4501                	li	a0,0
}
  96:	8082                	ret
{
  98:	1101                	addi	sp,sp,-32
  9a:	ec06                	sd	ra,24(sp)
  9c:	e822                	sd	s0,16(sp)
  9e:	e426                	sd	s1,8(sp)
  a0:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  a2:	01054483          	lbu	s1,16(a0)
  a6:	00000097          	auipc	ra,0x0
  aa:	172080e7          	jalr	370(ra) # 218 <twhoami>
  ae:	2501                	sext.w	a0,a0
  b0:	40a48533          	sub	a0,s1,a0
  b4:	00153513          	seqz	a0,a0
}
  b8:	60e2                	ld	ra,24(sp)
  ba:	6442                	ld	s0,16(sp)
  bc:	64a2                	ld	s1,8(sp)
  be:	6105                	addi	sp,sp,32
  c0:	8082                	ret

00000000000000c2 <acquire>:

void acquire(struct lock *lk)
{
  c2:	7179                	addi	sp,sp,-48
  c4:	f406                	sd	ra,40(sp)
  c6:	f022                	sd	s0,32(sp)
  c8:	ec26                	sd	s1,24(sp)
  ca:	e84a                	sd	s2,16(sp)
  cc:	e44e                	sd	s3,8(sp)
  ce:	e052                	sd	s4,0(sp)
  d0:	1800                	addi	s0,sp,48
  d2:	8a2a                	mv	s4,a0
    if (holding(lk))
  d4:	00000097          	auipc	ra,0x0
  d8:	fba080e7          	jalr	-70(ra) # 8e <holding>
  dc:	e919                	bnez	a0,f2 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  de:	ffca7493          	andi	s1,s4,-4
  e2:	003a7913          	andi	s2,s4,3
  e6:	0039191b          	slliw	s2,s2,0x3
  ea:	4985                	li	s3,1
  ec:	012999bb          	sllw	s3,s3,s2
  f0:	a015                	j	114 <acquire+0x52>
        printf("re-acquiring lock we already hold");
  f2:	00001517          	auipc	a0,0x1
  f6:	99650513          	addi	a0,a0,-1642 # a88 <malloc+0x120>
  fa:	00000097          	auipc	ra,0x0
  fe:	7b6080e7          	jalr	1974(ra) # 8b0 <printf>
        exit(-1);
 102:	557d                	li	a0,-1
 104:	00000097          	auipc	ra,0x0
 108:	42c080e7          	jalr	1068(ra) # 530 <exit>
    {
        // give up the cpu for other threads
        tyield();
 10c:	00000097          	auipc	ra,0x0
 110:	0f4080e7          	jalr	244(ra) # 200 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 114:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 118:	0127d7bb          	srlw	a5,a5,s2
 11c:	0ff7f793          	zext.b	a5,a5
 120:	f7f5                	bnez	a5,10c <acquire+0x4a>
    }

    __sync_synchronize();
 122:	0ff0000f          	fence

    lk->tid = twhoami();
 126:	00000097          	auipc	ra,0x0
 12a:	0f2080e7          	jalr	242(ra) # 218 <twhoami>
 12e:	00aa0823          	sb	a0,16(s4)
}
 132:	70a2                	ld	ra,40(sp)
 134:	7402                	ld	s0,32(sp)
 136:	64e2                	ld	s1,24(sp)
 138:	6942                	ld	s2,16(sp)
 13a:	69a2                	ld	s3,8(sp)
 13c:	6a02                	ld	s4,0(sp)
 13e:	6145                	addi	sp,sp,48
 140:	8082                	ret

0000000000000142 <release>:

void release(struct lock *lk)
{
 142:	1101                	addi	sp,sp,-32
 144:	ec06                	sd	ra,24(sp)
 146:	e822                	sd	s0,16(sp)
 148:	e426                	sd	s1,8(sp)
 14a:	1000                	addi	s0,sp,32
 14c:	84aa                	mv	s1,a0
    if (!holding(lk))
 14e:	00000097          	auipc	ra,0x0
 152:	f40080e7          	jalr	-192(ra) # 8e <holding>
 156:	c11d                	beqz	a0,17c <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 158:	57fd                	li	a5,-1
 15a:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 15e:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 162:	0ff0000f          	fence
 166:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 16a:	00000097          	auipc	ra,0x0
 16e:	096080e7          	jalr	150(ra) # 200 <tyield>
}
 172:	60e2                	ld	ra,24(sp)
 174:	6442                	ld	s0,16(sp)
 176:	64a2                	ld	s1,8(sp)
 178:	6105                	addi	sp,sp,32
 17a:	8082                	ret
        printf("releasing lock we are not holding");
 17c:	00001517          	auipc	a0,0x1
 180:	93450513          	addi	a0,a0,-1740 # ab0 <malloc+0x148>
 184:	00000097          	auipc	ra,0x0
 188:	72c080e7          	jalr	1836(ra) # 8b0 <printf>
        exit(-1);
 18c:	557d                	li	a0,-1
 18e:	00000097          	auipc	ra,0x0
 192:	3a2080e7          	jalr	930(ra) # 530 <exit>

0000000000000196 <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
 196:	1141                	addi	sp,sp,-16
 198:	e422                	sd	s0,8(sp)
 19a:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 19c:	00001717          	auipc	a4,0x1
 1a0:	e6473703          	ld	a4,-412(a4) # 1000 <current_thread>
 1a4:	47c1                	li	a5,16
 1a6:	c319                	beqz	a4,1ac <tsched+0x16>
    for (int i = 0; i < 16; i++) {
 1a8:	37fd                	addiw	a5,a5,-1
 1aa:	fff5                	bnez	a5,1a6 <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
 1ac:	6422                	ld	s0,8(sp)
 1ae:	0141                	addi	sp,sp,16
 1b0:	8082                	ret

00000000000001b2 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 1b2:	7179                	addi	sp,sp,-48
 1b4:	f406                	sd	ra,40(sp)
 1b6:	f022                	sd	s0,32(sp)
 1b8:	ec26                	sd	s1,24(sp)
 1ba:	e84a                	sd	s2,16(sp)
 1bc:	e44e                	sd	s3,8(sp)
 1be:	1800                	addi	s0,sp,48
 1c0:	84aa                	mv	s1,a0
 1c2:	89b2                	mv	s3,a2
 1c4:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 1c6:	09000513          	li	a0,144
 1ca:	00000097          	auipc	ra,0x0
 1ce:	79e080e7          	jalr	1950(ra) # 968 <malloc>
 1d2:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 1d4:	478d                	li	a5,3
 1d6:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 1d8:	609c                	ld	a5,0(s1)
 1da:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 1de:	609c                	ld	a5,0(s1)
 1e0:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
 1e4:	70a2                	ld	ra,40(sp)
 1e6:	7402                	ld	s0,32(sp)
 1e8:	64e2                	ld	s1,24(sp)
 1ea:	6942                	ld	s2,16(sp)
 1ec:	69a2                	ld	s3,8(sp)
 1ee:	6145                	addi	sp,sp,48
 1f0:	8082                	ret

00000000000001f2 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 1f2:	1141                	addi	sp,sp,-16
 1f4:	e422                	sd	s0,8(sp)
 1f6:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
 1f8:	4501                	li	a0,0
 1fa:	6422                	ld	s0,8(sp)
 1fc:	0141                	addi	sp,sp,16
 1fe:	8082                	ret

0000000000000200 <tyield>:

void tyield()
{
 200:	1141                	addi	sp,sp,-16
 202:	e422                	sd	s0,8(sp)
 204:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 206:	00001797          	auipc	a5,0x1
 20a:	dfa7b783          	ld	a5,-518(a5) # 1000 <current_thread>
 20e:	470d                	li	a4,3
 210:	dfb8                	sw	a4,120(a5)
    tsched();
}
 212:	6422                	ld	s0,8(sp)
 214:	0141                	addi	sp,sp,16
 216:	8082                	ret

0000000000000218 <twhoami>:

uint8 twhoami()
{
 218:	1141                	addi	sp,sp,-16
 21a:	e422                	sd	s0,8(sp)
 21c:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
 21e:	4501                	li	a0,0
 220:	6422                	ld	s0,8(sp)
 222:	0141                	addi	sp,sp,16
 224:	8082                	ret

0000000000000226 <tswtch>:
 226:	00153023          	sd	ra,0(a0)
 22a:	00253423          	sd	sp,8(a0)
 22e:	e900                	sd	s0,16(a0)
 230:	ed04                	sd	s1,24(a0)
 232:	03253023          	sd	s2,32(a0)
 236:	03353423          	sd	s3,40(a0)
 23a:	03453823          	sd	s4,48(a0)
 23e:	03553c23          	sd	s5,56(a0)
 242:	05653023          	sd	s6,64(a0)
 246:	05753423          	sd	s7,72(a0)
 24a:	05853823          	sd	s8,80(a0)
 24e:	05953c23          	sd	s9,88(a0)
 252:	07a53023          	sd	s10,96(a0)
 256:	07b53423          	sd	s11,104(a0)
 25a:	0005b083          	ld	ra,0(a1)
 25e:	0085b103          	ld	sp,8(a1)
 262:	6980                	ld	s0,16(a1)
 264:	6d84                	ld	s1,24(a1)
 266:	0205b903          	ld	s2,32(a1)
 26a:	0285b983          	ld	s3,40(a1)
 26e:	0305ba03          	ld	s4,48(a1)
 272:	0385ba83          	ld	s5,56(a1)
 276:	0405bb03          	ld	s6,64(a1)
 27a:	0485bb83          	ld	s7,72(a1)
 27e:	0505bc03          	ld	s8,80(a1)
 282:	0585bc83          	ld	s9,88(a1)
 286:	0605bd03          	ld	s10,96(a1)
 28a:	0685bd83          	ld	s11,104(a1)
 28e:	8082                	ret

0000000000000290 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 290:	1101                	addi	sp,sp,-32
 292:	ec06                	sd	ra,24(sp)
 294:	e822                	sd	s0,16(sp)
 296:	e426                	sd	s1,8(sp)
 298:	e04a                	sd	s2,0(sp)
 29a:	1000                	addi	s0,sp,32
 29c:	84aa                	mv	s1,a0
 29e:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 2a0:	09000513          	li	a0,144
 2a4:	00000097          	auipc	ra,0x0
 2a8:	6c4080e7          	jalr	1732(ra) # 968 <malloc>

    main_thread->tid = 0;
 2ac:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 2b0:	85ca                	mv	a1,s2
 2b2:	8526                	mv	a0,s1
 2b4:	00000097          	auipc	ra,0x0
 2b8:	d4c080e7          	jalr	-692(ra) # 0 <main>
    exit(res);
 2bc:	00000097          	auipc	ra,0x0
 2c0:	274080e7          	jalr	628(ra) # 530 <exit>

00000000000002c4 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 2c4:	1141                	addi	sp,sp,-16
 2c6:	e422                	sd	s0,8(sp)
 2c8:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 2ca:	87aa                	mv	a5,a0
 2cc:	0585                	addi	a1,a1,1
 2ce:	0785                	addi	a5,a5,1
 2d0:	fff5c703          	lbu	a4,-1(a1)
 2d4:	fee78fa3          	sb	a4,-1(a5)
 2d8:	fb75                	bnez	a4,2cc <strcpy+0x8>
        ;
    return os;
}
 2da:	6422                	ld	s0,8(sp)
 2dc:	0141                	addi	sp,sp,16
 2de:	8082                	ret

00000000000002e0 <strcmp>:

int strcmp(const char *p, const char *q)
{
 2e0:	1141                	addi	sp,sp,-16
 2e2:	e422                	sd	s0,8(sp)
 2e4:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 2e6:	00054783          	lbu	a5,0(a0)
 2ea:	cb91                	beqz	a5,2fe <strcmp+0x1e>
 2ec:	0005c703          	lbu	a4,0(a1)
 2f0:	00f71763          	bne	a4,a5,2fe <strcmp+0x1e>
        p++, q++;
 2f4:	0505                	addi	a0,a0,1
 2f6:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 2f8:	00054783          	lbu	a5,0(a0)
 2fc:	fbe5                	bnez	a5,2ec <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 2fe:	0005c503          	lbu	a0,0(a1)
}
 302:	40a7853b          	subw	a0,a5,a0
 306:	6422                	ld	s0,8(sp)
 308:	0141                	addi	sp,sp,16
 30a:	8082                	ret

000000000000030c <strlen>:

uint strlen(const char *s)
{
 30c:	1141                	addi	sp,sp,-16
 30e:	e422                	sd	s0,8(sp)
 310:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 312:	00054783          	lbu	a5,0(a0)
 316:	cf91                	beqz	a5,332 <strlen+0x26>
 318:	0505                	addi	a0,a0,1
 31a:	87aa                	mv	a5,a0
 31c:	86be                	mv	a3,a5
 31e:	0785                	addi	a5,a5,1
 320:	fff7c703          	lbu	a4,-1(a5)
 324:	ff65                	bnez	a4,31c <strlen+0x10>
 326:	40a6853b          	subw	a0,a3,a0
 32a:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 32c:	6422                	ld	s0,8(sp)
 32e:	0141                	addi	sp,sp,16
 330:	8082                	ret
    for (n = 0; s[n]; n++)
 332:	4501                	li	a0,0
 334:	bfe5                	j	32c <strlen+0x20>

0000000000000336 <memset>:

void *
memset(void *dst, int c, uint n)
{
 336:	1141                	addi	sp,sp,-16
 338:	e422                	sd	s0,8(sp)
 33a:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 33c:	ca19                	beqz	a2,352 <memset+0x1c>
 33e:	87aa                	mv	a5,a0
 340:	1602                	slli	a2,a2,0x20
 342:	9201                	srli	a2,a2,0x20
 344:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 348:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 34c:	0785                	addi	a5,a5,1
 34e:	fee79de3          	bne	a5,a4,348 <memset+0x12>
    }
    return dst;
}
 352:	6422                	ld	s0,8(sp)
 354:	0141                	addi	sp,sp,16
 356:	8082                	ret

0000000000000358 <strchr>:

char *
strchr(const char *s, char c)
{
 358:	1141                	addi	sp,sp,-16
 35a:	e422                	sd	s0,8(sp)
 35c:	0800                	addi	s0,sp,16
    for (; *s; s++)
 35e:	00054783          	lbu	a5,0(a0)
 362:	cb99                	beqz	a5,378 <strchr+0x20>
        if (*s == c)
 364:	00f58763          	beq	a1,a5,372 <strchr+0x1a>
    for (; *s; s++)
 368:	0505                	addi	a0,a0,1
 36a:	00054783          	lbu	a5,0(a0)
 36e:	fbfd                	bnez	a5,364 <strchr+0xc>
            return (char *)s;
    return 0;
 370:	4501                	li	a0,0
}
 372:	6422                	ld	s0,8(sp)
 374:	0141                	addi	sp,sp,16
 376:	8082                	ret
    return 0;
 378:	4501                	li	a0,0
 37a:	bfe5                	j	372 <strchr+0x1a>

000000000000037c <gets>:

char *
gets(char *buf, int max)
{
 37c:	711d                	addi	sp,sp,-96
 37e:	ec86                	sd	ra,88(sp)
 380:	e8a2                	sd	s0,80(sp)
 382:	e4a6                	sd	s1,72(sp)
 384:	e0ca                	sd	s2,64(sp)
 386:	fc4e                	sd	s3,56(sp)
 388:	f852                	sd	s4,48(sp)
 38a:	f456                	sd	s5,40(sp)
 38c:	f05a                	sd	s6,32(sp)
 38e:	ec5e                	sd	s7,24(sp)
 390:	1080                	addi	s0,sp,96
 392:	8baa                	mv	s7,a0
 394:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 396:	892a                	mv	s2,a0
 398:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 39a:	4aa9                	li	s5,10
 39c:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 39e:	89a6                	mv	s3,s1
 3a0:	2485                	addiw	s1,s1,1
 3a2:	0344d863          	bge	s1,s4,3d2 <gets+0x56>
        cc = read(0, &c, 1);
 3a6:	4605                	li	a2,1
 3a8:	faf40593          	addi	a1,s0,-81
 3ac:	4501                	li	a0,0
 3ae:	00000097          	auipc	ra,0x0
 3b2:	19a080e7          	jalr	410(ra) # 548 <read>
        if (cc < 1)
 3b6:	00a05e63          	blez	a0,3d2 <gets+0x56>
        buf[i++] = c;
 3ba:	faf44783          	lbu	a5,-81(s0)
 3be:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 3c2:	01578763          	beq	a5,s5,3d0 <gets+0x54>
 3c6:	0905                	addi	s2,s2,1
 3c8:	fd679be3          	bne	a5,s6,39e <gets+0x22>
    for (i = 0; i + 1 < max;)
 3cc:	89a6                	mv	s3,s1
 3ce:	a011                	j	3d2 <gets+0x56>
 3d0:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 3d2:	99de                	add	s3,s3,s7
 3d4:	00098023          	sb	zero,0(s3)
    return buf;
}
 3d8:	855e                	mv	a0,s7
 3da:	60e6                	ld	ra,88(sp)
 3dc:	6446                	ld	s0,80(sp)
 3de:	64a6                	ld	s1,72(sp)
 3e0:	6906                	ld	s2,64(sp)
 3e2:	79e2                	ld	s3,56(sp)
 3e4:	7a42                	ld	s4,48(sp)
 3e6:	7aa2                	ld	s5,40(sp)
 3e8:	7b02                	ld	s6,32(sp)
 3ea:	6be2                	ld	s7,24(sp)
 3ec:	6125                	addi	sp,sp,96
 3ee:	8082                	ret

00000000000003f0 <stat>:

int stat(const char *n, struct stat *st)
{
 3f0:	1101                	addi	sp,sp,-32
 3f2:	ec06                	sd	ra,24(sp)
 3f4:	e822                	sd	s0,16(sp)
 3f6:	e426                	sd	s1,8(sp)
 3f8:	e04a                	sd	s2,0(sp)
 3fa:	1000                	addi	s0,sp,32
 3fc:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 3fe:	4581                	li	a1,0
 400:	00000097          	auipc	ra,0x0
 404:	170080e7          	jalr	368(ra) # 570 <open>
    if (fd < 0)
 408:	02054563          	bltz	a0,432 <stat+0x42>
 40c:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 40e:	85ca                	mv	a1,s2
 410:	00000097          	auipc	ra,0x0
 414:	178080e7          	jalr	376(ra) # 588 <fstat>
 418:	892a                	mv	s2,a0
    close(fd);
 41a:	8526                	mv	a0,s1
 41c:	00000097          	auipc	ra,0x0
 420:	13c080e7          	jalr	316(ra) # 558 <close>
    return r;
}
 424:	854a                	mv	a0,s2
 426:	60e2                	ld	ra,24(sp)
 428:	6442                	ld	s0,16(sp)
 42a:	64a2                	ld	s1,8(sp)
 42c:	6902                	ld	s2,0(sp)
 42e:	6105                	addi	sp,sp,32
 430:	8082                	ret
        return -1;
 432:	597d                	li	s2,-1
 434:	bfc5                	j	424 <stat+0x34>

0000000000000436 <atoi>:

int atoi(const char *s)
{
 436:	1141                	addi	sp,sp,-16
 438:	e422                	sd	s0,8(sp)
 43a:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 43c:	00054683          	lbu	a3,0(a0)
 440:	fd06879b          	addiw	a5,a3,-48
 444:	0ff7f793          	zext.b	a5,a5
 448:	4625                	li	a2,9
 44a:	02f66863          	bltu	a2,a5,47a <atoi+0x44>
 44e:	872a                	mv	a4,a0
    n = 0;
 450:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 452:	0705                	addi	a4,a4,1
 454:	0025179b          	slliw	a5,a0,0x2
 458:	9fa9                	addw	a5,a5,a0
 45a:	0017979b          	slliw	a5,a5,0x1
 45e:	9fb5                	addw	a5,a5,a3
 460:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 464:	00074683          	lbu	a3,0(a4)
 468:	fd06879b          	addiw	a5,a3,-48
 46c:	0ff7f793          	zext.b	a5,a5
 470:	fef671e3          	bgeu	a2,a5,452 <atoi+0x1c>
    return n;
}
 474:	6422                	ld	s0,8(sp)
 476:	0141                	addi	sp,sp,16
 478:	8082                	ret
    n = 0;
 47a:	4501                	li	a0,0
 47c:	bfe5                	j	474 <atoi+0x3e>

000000000000047e <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 47e:	1141                	addi	sp,sp,-16
 480:	e422                	sd	s0,8(sp)
 482:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 484:	02b57463          	bgeu	a0,a1,4ac <memmove+0x2e>
    {
        while (n-- > 0)
 488:	00c05f63          	blez	a2,4a6 <memmove+0x28>
 48c:	1602                	slli	a2,a2,0x20
 48e:	9201                	srli	a2,a2,0x20
 490:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 494:	872a                	mv	a4,a0
            *dst++ = *src++;
 496:	0585                	addi	a1,a1,1
 498:	0705                	addi	a4,a4,1
 49a:	fff5c683          	lbu	a3,-1(a1)
 49e:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 4a2:	fee79ae3          	bne	a5,a4,496 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 4a6:	6422                	ld	s0,8(sp)
 4a8:	0141                	addi	sp,sp,16
 4aa:	8082                	ret
        dst += n;
 4ac:	00c50733          	add	a4,a0,a2
        src += n;
 4b0:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 4b2:	fec05ae3          	blez	a2,4a6 <memmove+0x28>
 4b6:	fff6079b          	addiw	a5,a2,-1
 4ba:	1782                	slli	a5,a5,0x20
 4bc:	9381                	srli	a5,a5,0x20
 4be:	fff7c793          	not	a5,a5
 4c2:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 4c4:	15fd                	addi	a1,a1,-1
 4c6:	177d                	addi	a4,a4,-1
 4c8:	0005c683          	lbu	a3,0(a1)
 4cc:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 4d0:	fee79ae3          	bne	a5,a4,4c4 <memmove+0x46>
 4d4:	bfc9                	j	4a6 <memmove+0x28>

00000000000004d6 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 4d6:	1141                	addi	sp,sp,-16
 4d8:	e422                	sd	s0,8(sp)
 4da:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 4dc:	ca05                	beqz	a2,50c <memcmp+0x36>
 4de:	fff6069b          	addiw	a3,a2,-1
 4e2:	1682                	slli	a3,a3,0x20
 4e4:	9281                	srli	a3,a3,0x20
 4e6:	0685                	addi	a3,a3,1
 4e8:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 4ea:	00054783          	lbu	a5,0(a0)
 4ee:	0005c703          	lbu	a4,0(a1)
 4f2:	00e79863          	bne	a5,a4,502 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 4f6:	0505                	addi	a0,a0,1
        p2++;
 4f8:	0585                	addi	a1,a1,1
    while (n-- > 0)
 4fa:	fed518e3          	bne	a0,a3,4ea <memcmp+0x14>
    }
    return 0;
 4fe:	4501                	li	a0,0
 500:	a019                	j	506 <memcmp+0x30>
            return *p1 - *p2;
 502:	40e7853b          	subw	a0,a5,a4
}
 506:	6422                	ld	s0,8(sp)
 508:	0141                	addi	sp,sp,16
 50a:	8082                	ret
    return 0;
 50c:	4501                	li	a0,0
 50e:	bfe5                	j	506 <memcmp+0x30>

0000000000000510 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 510:	1141                	addi	sp,sp,-16
 512:	e406                	sd	ra,8(sp)
 514:	e022                	sd	s0,0(sp)
 516:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 518:	00000097          	auipc	ra,0x0
 51c:	f66080e7          	jalr	-154(ra) # 47e <memmove>
}
 520:	60a2                	ld	ra,8(sp)
 522:	6402                	ld	s0,0(sp)
 524:	0141                	addi	sp,sp,16
 526:	8082                	ret

0000000000000528 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 528:	4885                	li	a7,1
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <exit>:
.global exit
exit:
 li a7, SYS_exit
 530:	4889                	li	a7,2
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <wait>:
.global wait
wait:
 li a7, SYS_wait
 538:	488d                	li	a7,3
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 540:	4891                	li	a7,4
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <read>:
.global read
read:
 li a7, SYS_read
 548:	4895                	li	a7,5
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <write>:
.global write
write:
 li a7, SYS_write
 550:	48c1                	li	a7,16
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <close>:
.global close
close:
 li a7, SYS_close
 558:	48d5                	li	a7,21
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <kill>:
.global kill
kill:
 li a7, SYS_kill
 560:	4899                	li	a7,6
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <exec>:
.global exec
exec:
 li a7, SYS_exec
 568:	489d                	li	a7,7
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <open>:
.global open
open:
 li a7, SYS_open
 570:	48bd                	li	a7,15
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 578:	48c5                	li	a7,17
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 580:	48c9                	li	a7,18
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 588:	48a1                	li	a7,8
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <link>:
.global link
link:
 li a7, SYS_link
 590:	48cd                	li	a7,19
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 598:	48d1                	li	a7,20
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5a0:	48a5                	li	a7,9
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5a8:	48a9                	li	a7,10
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5b0:	48ad                	li	a7,11
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5b8:	48b1                	li	a7,12
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5c0:	48b5                	li	a7,13
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5c8:	48b9                	li	a7,14
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <ps>:
.global ps
ps:
 li a7, SYS_ps
 5d0:	48d9                	li	a7,22
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 5d8:	48dd                	li	a7,23
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 5e0:	48e1                	li	a7,24
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5e8:	1101                	addi	sp,sp,-32
 5ea:	ec06                	sd	ra,24(sp)
 5ec:	e822                	sd	s0,16(sp)
 5ee:	1000                	addi	s0,sp,32
 5f0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5f4:	4605                	li	a2,1
 5f6:	fef40593          	addi	a1,s0,-17
 5fa:	00000097          	auipc	ra,0x0
 5fe:	f56080e7          	jalr	-170(ra) # 550 <write>
}
 602:	60e2                	ld	ra,24(sp)
 604:	6442                	ld	s0,16(sp)
 606:	6105                	addi	sp,sp,32
 608:	8082                	ret

000000000000060a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 60a:	7139                	addi	sp,sp,-64
 60c:	fc06                	sd	ra,56(sp)
 60e:	f822                	sd	s0,48(sp)
 610:	f426                	sd	s1,40(sp)
 612:	f04a                	sd	s2,32(sp)
 614:	ec4e                	sd	s3,24(sp)
 616:	0080                	addi	s0,sp,64
 618:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 61a:	c299                	beqz	a3,620 <printint+0x16>
 61c:	0805c963          	bltz	a1,6ae <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 620:	2581                	sext.w	a1,a1
  neg = 0;
 622:	4881                	li	a7,0
 624:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 628:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 62a:	2601                	sext.w	a2,a2
 62c:	00000517          	auipc	a0,0x0
 630:	50c50513          	addi	a0,a0,1292 # b38 <digits>
 634:	883a                	mv	a6,a4
 636:	2705                	addiw	a4,a4,1
 638:	02c5f7bb          	remuw	a5,a1,a2
 63c:	1782                	slli	a5,a5,0x20
 63e:	9381                	srli	a5,a5,0x20
 640:	97aa                	add	a5,a5,a0
 642:	0007c783          	lbu	a5,0(a5)
 646:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 64a:	0005879b          	sext.w	a5,a1
 64e:	02c5d5bb          	divuw	a1,a1,a2
 652:	0685                	addi	a3,a3,1
 654:	fec7f0e3          	bgeu	a5,a2,634 <printint+0x2a>
  if(neg)
 658:	00088c63          	beqz	a7,670 <printint+0x66>
    buf[i++] = '-';
 65c:	fd070793          	addi	a5,a4,-48
 660:	00878733          	add	a4,a5,s0
 664:	02d00793          	li	a5,45
 668:	fef70823          	sb	a5,-16(a4)
 66c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 670:	02e05863          	blez	a4,6a0 <printint+0x96>
 674:	fc040793          	addi	a5,s0,-64
 678:	00e78933          	add	s2,a5,a4
 67c:	fff78993          	addi	s3,a5,-1
 680:	99ba                	add	s3,s3,a4
 682:	377d                	addiw	a4,a4,-1
 684:	1702                	slli	a4,a4,0x20
 686:	9301                	srli	a4,a4,0x20
 688:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 68c:	fff94583          	lbu	a1,-1(s2)
 690:	8526                	mv	a0,s1
 692:	00000097          	auipc	ra,0x0
 696:	f56080e7          	jalr	-170(ra) # 5e8 <putc>
  while(--i >= 0)
 69a:	197d                	addi	s2,s2,-1
 69c:	ff3918e3          	bne	s2,s3,68c <printint+0x82>
}
 6a0:	70e2                	ld	ra,56(sp)
 6a2:	7442                	ld	s0,48(sp)
 6a4:	74a2                	ld	s1,40(sp)
 6a6:	7902                	ld	s2,32(sp)
 6a8:	69e2                	ld	s3,24(sp)
 6aa:	6121                	addi	sp,sp,64
 6ac:	8082                	ret
    x = -xx;
 6ae:	40b005bb          	negw	a1,a1
    neg = 1;
 6b2:	4885                	li	a7,1
    x = -xx;
 6b4:	bf85                	j	624 <printint+0x1a>

00000000000006b6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6b6:	715d                	addi	sp,sp,-80
 6b8:	e486                	sd	ra,72(sp)
 6ba:	e0a2                	sd	s0,64(sp)
 6bc:	fc26                	sd	s1,56(sp)
 6be:	f84a                	sd	s2,48(sp)
 6c0:	f44e                	sd	s3,40(sp)
 6c2:	f052                	sd	s4,32(sp)
 6c4:	ec56                	sd	s5,24(sp)
 6c6:	e85a                	sd	s6,16(sp)
 6c8:	e45e                	sd	s7,8(sp)
 6ca:	e062                	sd	s8,0(sp)
 6cc:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6ce:	0005c903          	lbu	s2,0(a1)
 6d2:	18090c63          	beqz	s2,86a <vprintf+0x1b4>
 6d6:	8aaa                	mv	s5,a0
 6d8:	8bb2                	mv	s7,a2
 6da:	00158493          	addi	s1,a1,1
  state = 0;
 6de:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6e0:	02500a13          	li	s4,37
 6e4:	4b55                	li	s6,21
 6e6:	a839                	j	704 <vprintf+0x4e>
        putc(fd, c);
 6e8:	85ca                	mv	a1,s2
 6ea:	8556                	mv	a0,s5
 6ec:	00000097          	auipc	ra,0x0
 6f0:	efc080e7          	jalr	-260(ra) # 5e8 <putc>
 6f4:	a019                	j	6fa <vprintf+0x44>
    } else if(state == '%'){
 6f6:	01498d63          	beq	s3,s4,710 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 6fa:	0485                	addi	s1,s1,1
 6fc:	fff4c903          	lbu	s2,-1(s1)
 700:	16090563          	beqz	s2,86a <vprintf+0x1b4>
    if(state == 0){
 704:	fe0999e3          	bnez	s3,6f6 <vprintf+0x40>
      if(c == '%'){
 708:	ff4910e3          	bne	s2,s4,6e8 <vprintf+0x32>
        state = '%';
 70c:	89d2                	mv	s3,s4
 70e:	b7f5                	j	6fa <vprintf+0x44>
      if(c == 'd'){
 710:	13490263          	beq	s2,s4,834 <vprintf+0x17e>
 714:	f9d9079b          	addiw	a5,s2,-99
 718:	0ff7f793          	zext.b	a5,a5
 71c:	12fb6563          	bltu	s6,a5,846 <vprintf+0x190>
 720:	f9d9079b          	addiw	a5,s2,-99
 724:	0ff7f713          	zext.b	a4,a5
 728:	10eb6f63          	bltu	s6,a4,846 <vprintf+0x190>
 72c:	00271793          	slli	a5,a4,0x2
 730:	00000717          	auipc	a4,0x0
 734:	3b070713          	addi	a4,a4,944 # ae0 <malloc+0x178>
 738:	97ba                	add	a5,a5,a4
 73a:	439c                	lw	a5,0(a5)
 73c:	97ba                	add	a5,a5,a4
 73e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 740:	008b8913          	addi	s2,s7,8
 744:	4685                	li	a3,1
 746:	4629                	li	a2,10
 748:	000ba583          	lw	a1,0(s7)
 74c:	8556                	mv	a0,s5
 74e:	00000097          	auipc	ra,0x0
 752:	ebc080e7          	jalr	-324(ra) # 60a <printint>
 756:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 758:	4981                	li	s3,0
 75a:	b745                	j	6fa <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 75c:	008b8913          	addi	s2,s7,8
 760:	4681                	li	a3,0
 762:	4629                	li	a2,10
 764:	000ba583          	lw	a1,0(s7)
 768:	8556                	mv	a0,s5
 76a:	00000097          	auipc	ra,0x0
 76e:	ea0080e7          	jalr	-352(ra) # 60a <printint>
 772:	8bca                	mv	s7,s2
      state = 0;
 774:	4981                	li	s3,0
 776:	b751                	j	6fa <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 778:	008b8913          	addi	s2,s7,8
 77c:	4681                	li	a3,0
 77e:	4641                	li	a2,16
 780:	000ba583          	lw	a1,0(s7)
 784:	8556                	mv	a0,s5
 786:	00000097          	auipc	ra,0x0
 78a:	e84080e7          	jalr	-380(ra) # 60a <printint>
 78e:	8bca                	mv	s7,s2
      state = 0;
 790:	4981                	li	s3,0
 792:	b7a5                	j	6fa <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 794:	008b8c13          	addi	s8,s7,8
 798:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 79c:	03000593          	li	a1,48
 7a0:	8556                	mv	a0,s5
 7a2:	00000097          	auipc	ra,0x0
 7a6:	e46080e7          	jalr	-442(ra) # 5e8 <putc>
  putc(fd, 'x');
 7aa:	07800593          	li	a1,120
 7ae:	8556                	mv	a0,s5
 7b0:	00000097          	auipc	ra,0x0
 7b4:	e38080e7          	jalr	-456(ra) # 5e8 <putc>
 7b8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7ba:	00000b97          	auipc	s7,0x0
 7be:	37eb8b93          	addi	s7,s7,894 # b38 <digits>
 7c2:	03c9d793          	srli	a5,s3,0x3c
 7c6:	97de                	add	a5,a5,s7
 7c8:	0007c583          	lbu	a1,0(a5)
 7cc:	8556                	mv	a0,s5
 7ce:	00000097          	auipc	ra,0x0
 7d2:	e1a080e7          	jalr	-486(ra) # 5e8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7d6:	0992                	slli	s3,s3,0x4
 7d8:	397d                	addiw	s2,s2,-1
 7da:	fe0914e3          	bnez	s2,7c2 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 7de:	8be2                	mv	s7,s8
      state = 0;
 7e0:	4981                	li	s3,0
 7e2:	bf21                	j	6fa <vprintf+0x44>
        s = va_arg(ap, char*);
 7e4:	008b8993          	addi	s3,s7,8
 7e8:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 7ec:	02090163          	beqz	s2,80e <vprintf+0x158>
        while(*s != 0){
 7f0:	00094583          	lbu	a1,0(s2)
 7f4:	c9a5                	beqz	a1,864 <vprintf+0x1ae>
          putc(fd, *s);
 7f6:	8556                	mv	a0,s5
 7f8:	00000097          	auipc	ra,0x0
 7fc:	df0080e7          	jalr	-528(ra) # 5e8 <putc>
          s++;
 800:	0905                	addi	s2,s2,1
        while(*s != 0){
 802:	00094583          	lbu	a1,0(s2)
 806:	f9e5                	bnez	a1,7f6 <vprintf+0x140>
        s = va_arg(ap, char*);
 808:	8bce                	mv	s7,s3
      state = 0;
 80a:	4981                	li	s3,0
 80c:	b5fd                	j	6fa <vprintf+0x44>
          s = "(null)";
 80e:	00000917          	auipc	s2,0x0
 812:	2ca90913          	addi	s2,s2,714 # ad8 <malloc+0x170>
        while(*s != 0){
 816:	02800593          	li	a1,40
 81a:	bff1                	j	7f6 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 81c:	008b8913          	addi	s2,s7,8
 820:	000bc583          	lbu	a1,0(s7)
 824:	8556                	mv	a0,s5
 826:	00000097          	auipc	ra,0x0
 82a:	dc2080e7          	jalr	-574(ra) # 5e8 <putc>
 82e:	8bca                	mv	s7,s2
      state = 0;
 830:	4981                	li	s3,0
 832:	b5e1                	j	6fa <vprintf+0x44>
        putc(fd, c);
 834:	02500593          	li	a1,37
 838:	8556                	mv	a0,s5
 83a:	00000097          	auipc	ra,0x0
 83e:	dae080e7          	jalr	-594(ra) # 5e8 <putc>
      state = 0;
 842:	4981                	li	s3,0
 844:	bd5d                	j	6fa <vprintf+0x44>
        putc(fd, '%');
 846:	02500593          	li	a1,37
 84a:	8556                	mv	a0,s5
 84c:	00000097          	auipc	ra,0x0
 850:	d9c080e7          	jalr	-612(ra) # 5e8 <putc>
        putc(fd, c);
 854:	85ca                	mv	a1,s2
 856:	8556                	mv	a0,s5
 858:	00000097          	auipc	ra,0x0
 85c:	d90080e7          	jalr	-624(ra) # 5e8 <putc>
      state = 0;
 860:	4981                	li	s3,0
 862:	bd61                	j	6fa <vprintf+0x44>
        s = va_arg(ap, char*);
 864:	8bce                	mv	s7,s3
      state = 0;
 866:	4981                	li	s3,0
 868:	bd49                	j	6fa <vprintf+0x44>
    }
  }
}
 86a:	60a6                	ld	ra,72(sp)
 86c:	6406                	ld	s0,64(sp)
 86e:	74e2                	ld	s1,56(sp)
 870:	7942                	ld	s2,48(sp)
 872:	79a2                	ld	s3,40(sp)
 874:	7a02                	ld	s4,32(sp)
 876:	6ae2                	ld	s5,24(sp)
 878:	6b42                	ld	s6,16(sp)
 87a:	6ba2                	ld	s7,8(sp)
 87c:	6c02                	ld	s8,0(sp)
 87e:	6161                	addi	sp,sp,80
 880:	8082                	ret

0000000000000882 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 882:	715d                	addi	sp,sp,-80
 884:	ec06                	sd	ra,24(sp)
 886:	e822                	sd	s0,16(sp)
 888:	1000                	addi	s0,sp,32
 88a:	e010                	sd	a2,0(s0)
 88c:	e414                	sd	a3,8(s0)
 88e:	e818                	sd	a4,16(s0)
 890:	ec1c                	sd	a5,24(s0)
 892:	03043023          	sd	a6,32(s0)
 896:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 89a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 89e:	8622                	mv	a2,s0
 8a0:	00000097          	auipc	ra,0x0
 8a4:	e16080e7          	jalr	-490(ra) # 6b6 <vprintf>
}
 8a8:	60e2                	ld	ra,24(sp)
 8aa:	6442                	ld	s0,16(sp)
 8ac:	6161                	addi	sp,sp,80
 8ae:	8082                	ret

00000000000008b0 <printf>:

void
printf(const char *fmt, ...)
{
 8b0:	711d                	addi	sp,sp,-96
 8b2:	ec06                	sd	ra,24(sp)
 8b4:	e822                	sd	s0,16(sp)
 8b6:	1000                	addi	s0,sp,32
 8b8:	e40c                	sd	a1,8(s0)
 8ba:	e810                	sd	a2,16(s0)
 8bc:	ec14                	sd	a3,24(s0)
 8be:	f018                	sd	a4,32(s0)
 8c0:	f41c                	sd	a5,40(s0)
 8c2:	03043823          	sd	a6,48(s0)
 8c6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8ca:	00840613          	addi	a2,s0,8
 8ce:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8d2:	85aa                	mv	a1,a0
 8d4:	4505                	li	a0,1
 8d6:	00000097          	auipc	ra,0x0
 8da:	de0080e7          	jalr	-544(ra) # 6b6 <vprintf>
}
 8de:	60e2                	ld	ra,24(sp)
 8e0:	6442                	ld	s0,16(sp)
 8e2:	6125                	addi	sp,sp,96
 8e4:	8082                	ret

00000000000008e6 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 8e6:	1141                	addi	sp,sp,-16
 8e8:	e422                	sd	s0,8(sp)
 8ea:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 8ec:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f0:	00000797          	auipc	a5,0x0
 8f4:	7187b783          	ld	a5,1816(a5) # 1008 <freep>
 8f8:	a02d                	j	922 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 8fa:	4618                	lw	a4,8(a2)
 8fc:	9f2d                	addw	a4,a4,a1
 8fe:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 902:	6398                	ld	a4,0(a5)
 904:	6310                	ld	a2,0(a4)
 906:	a83d                	j	944 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 908:	ff852703          	lw	a4,-8(a0)
 90c:	9f31                	addw	a4,a4,a2
 90e:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 910:	ff053683          	ld	a3,-16(a0)
 914:	a091                	j	958 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 916:	6398                	ld	a4,0(a5)
 918:	00e7e463          	bltu	a5,a4,920 <free+0x3a>
 91c:	00e6ea63          	bltu	a3,a4,930 <free+0x4a>
{
 920:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 922:	fed7fae3          	bgeu	a5,a3,916 <free+0x30>
 926:	6398                	ld	a4,0(a5)
 928:	00e6e463          	bltu	a3,a4,930 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 92c:	fee7eae3          	bltu	a5,a4,920 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 930:	ff852583          	lw	a1,-8(a0)
 934:	6390                	ld	a2,0(a5)
 936:	02059813          	slli	a6,a1,0x20
 93a:	01c85713          	srli	a4,a6,0x1c
 93e:	9736                	add	a4,a4,a3
 940:	fae60de3          	beq	a2,a4,8fa <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 944:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 948:	4790                	lw	a2,8(a5)
 94a:	02061593          	slli	a1,a2,0x20
 94e:	01c5d713          	srli	a4,a1,0x1c
 952:	973e                	add	a4,a4,a5
 954:	fae68ae3          	beq	a3,a4,908 <free+0x22>
        p->s.ptr = bp->s.ptr;
 958:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 95a:	00000717          	auipc	a4,0x0
 95e:	6af73723          	sd	a5,1710(a4) # 1008 <freep>
}
 962:	6422                	ld	s0,8(sp)
 964:	0141                	addi	sp,sp,16
 966:	8082                	ret

0000000000000968 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 968:	7139                	addi	sp,sp,-64
 96a:	fc06                	sd	ra,56(sp)
 96c:	f822                	sd	s0,48(sp)
 96e:	f426                	sd	s1,40(sp)
 970:	f04a                	sd	s2,32(sp)
 972:	ec4e                	sd	s3,24(sp)
 974:	e852                	sd	s4,16(sp)
 976:	e456                	sd	s5,8(sp)
 978:	e05a                	sd	s6,0(sp)
 97a:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 97c:	02051493          	slli	s1,a0,0x20
 980:	9081                	srli	s1,s1,0x20
 982:	04bd                	addi	s1,s1,15
 984:	8091                	srli	s1,s1,0x4
 986:	0014899b          	addiw	s3,s1,1
 98a:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 98c:	00000517          	auipc	a0,0x0
 990:	67c53503          	ld	a0,1660(a0) # 1008 <freep>
 994:	c515                	beqz	a0,9c0 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 996:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 998:	4798                	lw	a4,8(a5)
 99a:	02977f63          	bgeu	a4,s1,9d8 <malloc+0x70>
    if (nu < 4096)
 99e:	8a4e                	mv	s4,s3
 9a0:	0009871b          	sext.w	a4,s3
 9a4:	6685                	lui	a3,0x1
 9a6:	00d77363          	bgeu	a4,a3,9ac <malloc+0x44>
 9aa:	6a05                	lui	s4,0x1
 9ac:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 9b0:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 9b4:	00000917          	auipc	s2,0x0
 9b8:	65490913          	addi	s2,s2,1620 # 1008 <freep>
    if (p == (char *)-1)
 9bc:	5afd                	li	s5,-1
 9be:	a895                	j	a32 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 9c0:	00000797          	auipc	a5,0x0
 9c4:	65078793          	addi	a5,a5,1616 # 1010 <base>
 9c8:	00000717          	auipc	a4,0x0
 9cc:	64f73023          	sd	a5,1600(a4) # 1008 <freep>
 9d0:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 9d2:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 9d6:	b7e1                	j	99e <malloc+0x36>
            if (p->s.size == nunits)
 9d8:	02e48c63          	beq	s1,a4,a10 <malloc+0xa8>
                p->s.size -= nunits;
 9dc:	4137073b          	subw	a4,a4,s3
 9e0:	c798                	sw	a4,8(a5)
                p += p->s.size;
 9e2:	02071693          	slli	a3,a4,0x20
 9e6:	01c6d713          	srli	a4,a3,0x1c
 9ea:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 9ec:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 9f0:	00000717          	auipc	a4,0x0
 9f4:	60a73c23          	sd	a0,1560(a4) # 1008 <freep>
            return (void *)(p + 1);
 9f8:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 9fc:	70e2                	ld	ra,56(sp)
 9fe:	7442                	ld	s0,48(sp)
 a00:	74a2                	ld	s1,40(sp)
 a02:	7902                	ld	s2,32(sp)
 a04:	69e2                	ld	s3,24(sp)
 a06:	6a42                	ld	s4,16(sp)
 a08:	6aa2                	ld	s5,8(sp)
 a0a:	6b02                	ld	s6,0(sp)
 a0c:	6121                	addi	sp,sp,64
 a0e:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 a10:	6398                	ld	a4,0(a5)
 a12:	e118                	sd	a4,0(a0)
 a14:	bff1                	j	9f0 <malloc+0x88>
    hp->s.size = nu;
 a16:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 a1a:	0541                	addi	a0,a0,16
 a1c:	00000097          	auipc	ra,0x0
 a20:	eca080e7          	jalr	-310(ra) # 8e6 <free>
    return freep;
 a24:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 a28:	d971                	beqz	a0,9fc <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 a2a:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 a2c:	4798                	lw	a4,8(a5)
 a2e:	fa9775e3          	bgeu	a4,s1,9d8 <malloc+0x70>
        if (p == freep)
 a32:	00093703          	ld	a4,0(s2)
 a36:	853e                	mv	a0,a5
 a38:	fef719e3          	bne	a4,a5,a2a <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 a3c:	8552                	mv	a0,s4
 a3e:	00000097          	auipc	ra,0x0
 a42:	b7a080e7          	jalr	-1158(ra) # 5b8 <sbrk>
    if (p == (char *)-1)
 a46:	fd5518e3          	bne	a0,s5,a16 <malloc+0xae>
                return 0;
 a4a:	4501                	li	a0,0
 a4c:	bf45                	j	9fc <malloc+0x94>
