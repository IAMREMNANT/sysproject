/**
 * Variable 선언하기
 * 
 * 1) var - 더이상 쓰지 않는다.
 * 2) let
 * 3) const
 */

var name = '코드팩토리';
console.log(name);

var age = 32;
console.log(age);

let ive = '아이브';
console.log(ive);

/** 
 * let과 var로 선언하면
 * 값을 추후 변경할 수 있다.
 */

ive = '안유진';
console.log(ive);

const newJeans = '뉴진스';
console.log(newJeans);

//newJeans = '코드팩토리';

/**
 * const로 선언하면 
 * 추후 변경할 수 없다.
 *
 */

/** 
 * 선언과 할당
 * 
 * 1) 선언은 변수를 생성하는 것
 * 2) 할당은 변수에 값을 넣는 것
 */

var name = '코드팩토리';
console.log(name);

let girfriend;
console.log(girfriend);

const girfriend2;

/** 
 * const는 선언과 동시에 할당을 해야한다.
 * 
 */