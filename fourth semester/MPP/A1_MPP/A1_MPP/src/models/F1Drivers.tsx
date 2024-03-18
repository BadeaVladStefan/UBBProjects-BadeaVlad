export class F1Driver {
    private _id: number;
    private _name: string;
    private _team: string;
    private _age: number;
    private _is_visible: boolean;

    constructor(id: number, name: string, team: string, age: number, is_visible: boolean) {
        this._id = id;
        this._name = name;
        this._team = team;
        this._age = age;
        this._is_visible = is_visible;
    }

    //getters
    get id(): number {
        return this._id;
    }
    get name(): string{
        return this._name;
    }
    get team(): string{
        return this._team;
    }
    get age(): number{
        return this._age;
    }
    get is_visible(): boolean{
        return this._is_visible;
    }

    //setters
    set id(id: number){
        this._id = id;
    }
    set name(name: string){
        this._name = name;
    }
    set team(team: string){
        this._team = team;
    }
    set age(age: number){
        this._age = age;
    }
    set is_visible(is_visible: boolean){
        this._is_visible = is_visible;
    }

    //toString
    public toString = (): string =>{
        return 'F1 Driver: ' + this._name + ' Team: ' + this._team + ' Age: ' + this._age +'\n';
    }
}