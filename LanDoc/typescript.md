# TypeScript简要说明

## TypeScript 的使用

 ts 网上都有完整的教程，我这里就不多说了。只说一些，我的项目里 用的的一些实用的东西。ts网上的文档：[点击前往](https://tslang.cn/docs/handbook/basic-types.html)

### 基础类型

``` text
boolean：布尔类型
number：TypeScript所有的数值类型采用浮点型计数
string：字符串类型
Array：数组
Enum：枚举
any：任何类型，可以用来跳过TypeScript的编译时类型的检查
void：表明函数无返回值
null 空值
undefined 未定义
```

### 修饰符

``` typescript
public  a = 1; //公共的
private b = 2; //私有的
protected c = 3; //可继承的
```

默认不写是公共的

### 变量声明

 ``` typescript
    var a = 1;//js 的写法 ts 也可以，但是不推荐，推荐用let
    let b = 2;  // 跟var 一样的用法，但是 作用域不一样 let是 块作用域
    const c = 3;    //常量申请  不能写在类里边 可以写在 方法里。
    class Class1  {
       public d = 4;//类的公共变量
       public static e = 5;//类的静态变量
       public readonly f = 6; //只读的类变量，只能在 一开始或者构造函数里赋值
       public static readonly g = 7;//类的静态只读变量，只能一开始就赋值。
    }
 ```

### 类型别名

``` typescript
type UIData = {
    package?: string;
    id: number;
    createUiFun: () => fairygui.GComponent;
    uiType: UI_Type;
    uiLayer: number;
    bindAll?: () => void;
    isDestroy: boolean;
    isMask?: boolean;
    closeErr?: string;
    openErr?: string;
    openSound?: string;
    closeSound?: string;
}
function fun1(uiData:UIData):void{
}
function fun2(uiData:Object):void{
}
let stageVo:{[value:string]:StageVO};
function fun3(fun:(boolean)=>void):void{
    fun(true);
}
```

#### 类型别名跟接口很像 但是不能继承 它也不会生成js代码 它只起一个规范作用

 两个方法 fun1 和fun2 都是传入一个 uiData的Object类型的数据，但是如果没有 UIData 类型别名的约束，就很有可能传错参数。
 里边的  加一个 ?号 表示可有可无的 参数。
 一些简单的类型 不用再写一个类型别名，可以直接 :号后边写出来

### 接口

``` typescript
 interface BaseScene {
    /**场景id */
    sceneID: number;
    /**场景素材组 */
    preload?: string
    /**初始化场景 注册在这个场景里需要打开的界面*/
    initScene(): void;
    /**进入场景调用 */
    onEnter( args: any): void;
    /**退出场景 */
    onExit(): void;
}
class LoadScene implements BaseScene {
    constructor(public sceneID: number, public preload?: string) { }
    /**初始化场景 注册在这个场景里需要打开的界面*/
    initScene(): void {
        App.UIManager.registerID(PanelID.LOGIN_UI, LoadCtrl);
    }
    /**进入场景调用 */
    onEnter(): void {
        App.SceneManager.runScene(SceneID.Main_Scene, PanelID.LOGIN_UI);
    }
    /**退出场景 */
    onExit(): void {

    }
    /**切换场景的时候是否销毁，清空资源 */
    get isDestroy(): boolean {
        return false;
    }
}
```

### 抽象类 抽象方法 泛型类 泛型约束

``` typescript
  abstract class BaseCtrl<T extends fairygui.GComponent> {
    /**控制的界面 */
    private view_: T
    /**
     * 界面初始化完成的时候调用
     */
    public initView(_view: T): void {
        this.view_ = _view;
        this.init();
    }
    /**获取界面 */
    public get view(): T {
        return this.view_;
    }
    /**关闭界面 */
    public closeView(okFun?: Function, okObj?: any): void {
        if (okFun && okFun.bind) {
            okFun.bind(okObj);
        }
        else {
            okFun = null;
        }
        App.UIManager.closeID(this.uiData.id, okFun);
    }
    /**
     * 初始化完成
     */
    abstract init(): void;
    /**
     * 界面打开的时候调用
     */
    abstract open(...param: any[]): void;
    /**
     * 界面关闭的时候调用
     */
    abstract close(): void;
    /**
     * 界面销毁的时候调用
     */
    abstract destroy(): void;
    /**
     * 获取UI数据
     */
    abstract get uiData(): UIData;

}

class HelpFriendsOkCtrl extends BaseCtrl<GameView.UI_HelpFriendsOkView>{
    constructor() {
        super();
    }
    /**
    * 初始化完成
    */
    init(): void {
        this.view.m_ui.m_btn.addClickListener(this.closeView, this);
    }
    /**
     * 界面打开的时候调用
     */
    open(...param: any[]): void {
        let words = Game.Data.helpFriendsVO.helpWords;
        if (!words || words.length < 1) return;
        for (let i = 0; i < words.length; i++) {
            let item = this.view.m_ui.m_list.addItemFromPool();
            item.text = words[i];
        }
        this.view.m_ui.m_list.resizeToFit();
        let txt = Game.LangMgr.getTxt("收到答案弹窗文本",Game.Data.helpFriendsVO.playerName);
        this.view.m_ui.m_txt.text = txt;
    }
    /**
     * 界面关闭的时候调用
     */
    close(): void {

    }
    /**
     * 界面销毁的时候调用
     */
    destroy(): void {

    }
    /**
     * 获取UI数据
     */
    get uiData(): UIData {
        return {
            package: "GameView",
            id: PanelID.HELP_FRIENDSOK_UI,
            createUiFun: GameView.UI_HelpFriendsOkView.createInstance,
            uiType: UI_Type.CONSTS_UI,
            bindAll: () => {
                //GameView.GameViewBinder.bindAll();
                //fairygui.UIObjectFactory.setPackageItemExtension(WordNode.URL, WordNode);
            },
            uiLayer: 2,
            isDestroy: false
        };
    }
}
```

### 索引类型（Index types）

``` TypeScript
class Class1 {
    public a:number;
    public b:number;
    public getValue<U extends keyof Class1>(k: U): any {
        return this[k];
    }
    public setValue<U extends keyof Class1>(k: U, value: any): void {
        this[k] = value;
    }
}
```

外部调用的时候只能用 Class1的属性名字做参数。否则 编译报错

### 联合类型（Union Types）

``` typescript
function fun1(a:number|string):void{
    if(typeeof a ==="number"){

    }
    else if(typeeof a ==="string"){

    }
    //typeeof 只能判断基础类型；"number"， "string"， "boolean"或 "symbol"
    // 如果不是基础类型， 用 instanceof 判断比如说 if(a instanceof Class1);
}
```

### 方法参数

``` typescript
 function fun(id:string,name?:string,sex:string="男",...hobbys:string[]):void
```

id是必须参数。
name是可选参数 后面加 ?号。
sex也是可选参数。有默认值。
hobbys是剩余参数 如果你并不知道有几个参数传进来，可以用这个表示。