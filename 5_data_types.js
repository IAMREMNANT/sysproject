/**
 * Data Types
 * 
 * 여섯개의 Primitive Type과
 * 한 개의 오브젝트 타입이 있다.
 * 
 * Primitive Type은 가장 작은 단위이다. ex) 숫자 or 알파벳
 * 
 * 1) Number - 숫자
 * 2) String - 문자열 - 문자를 여러개로 묶은 것
 * 3) Boolean - 참과 거짓 
 * 4) undefiend - 정의가 되지 않은 타입
 * 5) null - 비어있는 값
 * 6) Symbol - 유일한 값
 *  
 * 7) Object - 오브젝트(객체)
 *    Function, Array, Date, RegExp 등이 있다.
 */

const age = 32;
const tempature = -10;
const pi = 3.14;

console.log(typeof age);
console.log(typeof tempature);
console.log(typeof pi);

const infinity = Infinity; // 무한대 값을 지정할 수 있음.
const nInfinity = -Infinity; // 음의 무한대 값을 지정할 수 있음.

console.log(typeof infinity);
console.log(typeof nInfinity);

/** 
 * String 타입
 */
const codeFactory = '코드팩토리';
console.log(typeof codeFactory);

const ive = "'아이브', 안유진";
console.log(ive);

/** 
 * Template Literal - 아무거나, 사람이 보는 대로 값을 입력하면 됨. -> ``
 * 
 * Escaping Character
 * 1) newline -> \n
 * 2) tab -> \t
 * 3) 백슬래시를 스트링으로 표현하고 싶다면 두번 입력하며 된다.
 */

const iveYujin = '아이브\n안유진';
console.log(iveYujin);
const Yujin = '아이브\t안유진';
console.log(Yujin);
const backSlash = "안유진\\팩토리";
console.log(backSlash);

const iveWonYoung2 = `아이브
장원영`;
console.log(iveWonYoung2);

console.log(typeof iveWonYoung2);

const groupName = '아이브';
console.log(groupName + ` 안유진`);
console.log(`${groupName} 안유진`);

/**
 * Boolean 타입
 */

const isTrue = true;
const isFalse = false;
console.log(typeof isTrue);
console.log(typeof isFalse);

/**
 * Undifined 타입
 * 
 * 사용자가 직접 값을 초기화하지 않았을 때
 * 지정되는 갑이다.
 * 
 * 선언만 하고 값을 지정하지 않았을 때
 * 직접 undefined로 값을 초기화하는건 지양해야 한다.
 */

let noInit;
console.log(noInit);
console.log(typeof noInit);

/**
 * null 타입
 * 
 * undefined와 마찬가지로 값이 없거나 뜻이나
 * JS에서는 개발자가 명시적으로 없는 값으로 초기화할 때 사용한다.
 */
let init = null;
console.log(init);
console.log(typeof init);

/**
 * Symbol 타입
 * 
 * 유일한 값을 만들 때 사용한다.
 * 다른 프리미티브 값들과 다르게 Symbol 함수를
 * 호출해서 사용한다.
 */

const test1 =  '1';
const test2 =  '1';

console.log(test1 === test2);

const symbol1 = Symbol('1');
const symbol2 = Symbol('1');

console.log(symbol1 === symbol2);

/**
 * Object 타입
 * JS는 모든 것이 Object이다.
 * 
 * Map
 * 키: 밸류의 쌍으로 이루어져있다.
 * key:value
 */

const dicitonary = { 
    red: '빨강',
    orange: '주황',
    yellow: '노랑',
};

console.log(dicitonary);
console.log(dicitionary['red'])