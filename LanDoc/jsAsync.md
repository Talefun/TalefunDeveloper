# 浅谈 JS 异步处理

Javascript 语言的执行环境是"单线程"（single thread）。"异步模式"非常重要。在浏览器端，耗时很长的操作都应该异步执行，避免浏览器失去响应，最好的例子就是Ajax操作。在服务器端，"异步模式"甚至是唯一的模式。

## 一、回调函数(CallBack)

``` javascript
  const postData = JSON.stringify({
    'msg': 'Hello World!'
  });

  const options = {
    hostname: 'www.google.com',
    port: 80,
    path: '/upload',
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Content-Length': Buffer.byteLength(postData)
    }
  };

  const req = http.request(options,res=>{
    console.log(`STATUS: ${res.statusCode}`);
    console.log(`HEADERS: ${JSON.stringify(res.headers)}`);
  });

  req.write(postData);
  req.end();
```

### 缺点

回调函数的优点是简单、容易理解和部署，缺点是不利于代码的阅读和维护，各个部分之间高度耦合（Coupling），流程会很混乱，而且每个任务只能指定一个回调函数。

``` javascript
  getData('/page/1?param=123', (res1) => {
      console.log(res1)
      getData(`/page/2?param=${res1.data}`, (res2) => {
          console.log(res2)
          getData(`/page/3?param=${res2.data}`, (res3) => {
              console.log(res3)
          })
      })
  })

```

由于后续请求依赖前一个请求的结果，所以我们只能把下一次请求写到上一次请求的回调函数内部，这样就形成了常说的：回调地狱。

## 二、事件监听(on)

另一种思路是采用事件驱动模式。任务的执行不取决于代码的顺序，而取决于某个事件是否发生。

首先，为f1绑定一个事件（这里采用的jQuery的写法), 当f1发生done事件，就执行f2。

``` javascript
  f1.on('done', f2);
```

f1.trigger('done')表示，执行完成后，立即触发done事件，从而开始执行f2。

``` javascript
　function f1() {

　　　setTimeout(() => {

　　　　　// f1的任务代码

　　　　　f1.trigger('done');

　　　}, 1000);

　}
```

### 优点

比较容易理解，可以绑定多个事件，每个事件可以指定多个回调函数，而且可以"去耦合"（Decoupling），有利于实现模块化。

### -缺点

整个程序都要变成事件驱动型，运行流程会变得很不清晰。

## 三、Promise

每一个异步任务返回一个Promise对象，该对象有一个then方法，允许指定回调函数。

``` javascript
  function getDataAsync (url) {
      return new Promise((resolve, reject) => {
          setTimeout(() => {
              const res = {
                  url: url,
                  data: Math.random()
              }
              resolve(res)
          }, 1000)
      })
  }

```

请求代码应该这样写:

``` javascript
  getDataAsync('/page/1?param=123')
      .then(res1 => {
          console.log(res1)
          return getDataAsync(`/page/2?param=${res1.data}`)
      })
      .then(res2 => {
          console.log(res2)
          return getDataAsync(`/page/3?param=${res2.data}`)
      })
      .then(res3 => {
          console.log(res3)
      })
```

### -优点

回调函数变成了链式写法，程序的流程可以看得很清楚，而且有一整套的配套方法，可以实现许多强大的功能。

### --缺点

编写和理解，都相对比较难；如果场景再复杂一点，比如后边的每一个请求依赖前面所有请求的结果，而不仅仅依赖上一次请求的结果，那会更复杂。

## 四、Generator

Generator 函数是协程在 ES6 的实现，最大特点就是可以交出函数的执行权（即暂停执行）。

``` javascript
  function* gen(x){
    const y = yield x + 2;
    return y;
  }

  const g = gen(1);
  g.next() // { value: 3, done: false }
  g.next() // { value: undefined, done: true }

```

上面代码中，调用 Generator 函数，会返回一个内部指针（即遍历器 ）g 。这是 Generator 函数不同于普通函数的另一个地方，即执行它不会返回结果，返回的是指针对象。调用指针 g 的 next 方法，会移动内部指针（即执行异步任务的第一段），指向第一个遇到的 yield 语句，上例是执行到 x + 2 为止。

``` javascript
  function getDataAsync (url) {
      return new Promise((resolve, reject) => {
          setTimeout(() => {
              const res = {
                  url: url,
                  data: Math.random()
              }
              resolve(res)
          }, 1000)
      })
  }
```

使用 Generator 函数可以这样写：

``` javascript
  function * getData () {
      const res1 = yield getDataAsync('/page/1?param=123')
      console.log(res1)
      const res2 = yield getDataAsync(`/page/2?param=${res1.data}`)
      console.log(res2)
      const res3 = yield getDataAsync(`/page/2?param=${res2.data}`)
      console.log(res3))
  }
```

## 五、async\await

async/await 是 Generator 函数处理异步的语法糖。

``` javascript
  async function getData () {
      const res1 = await getDataAsync('/page/1?param=123')
      console.log(res1)
      const res2 = await getDataAsync(`/page/2?param=${res1.data}`)
      console.log(res2)
      const res3 = await getDataAsync(`/page/2?param=${res2.data}`)
      console.log(res3)
  }
```

如果确实希望多个请求并发执行，可以使用 Promise.all 方法(先取得一组用户名，然后向数据库查询这些用户的分数，返回其中分数超过50的用户)：

``` javascript
const fn = async () => {
    const loginNames = await getLoginNames()
    const result = (await Promise.all(
        loginNames.map(async name => {
            const user = await db.collection("users").findOne({loginName: name})
            return user.score > 50 ? user : null
        })
    )).filter(m => m !== null)
    return result
}
```

## 参考

1. [async 函数的含义和用法](http://www.ruanyifeng.com/blog/2015/05/async.html)

2. [Generator 函数的含义与用法](http://www.ruanyifeng.com/blog/2015/04/generator.html)

3. [浅谈JavaScript中的异步处理](http://blog.poetries.top/2017/08/27/js_cb_promise_generator_async/)

4. [Javascript异步编程的4种方法](http://www.ruanyifeng.com/blog/2012/12/asynchronous%EF%BC%BFjavascript.html)