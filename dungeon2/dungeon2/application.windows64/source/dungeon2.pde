import java.util.*;

int mission = 0;
int score;
final int tile = 40;

boolean start;
boolean playAgain;

Hero hero;
Set<Goblin> goblins;
Set<Wizard> wizards;
Set<Blob> blobs;
Set<Ogre> ogres;
Set<Minotaur> minotaurs;
Set<Treasure> treasures;
Set<Potion> potions;

PImage heroIcon;
PImage goblinIcon;
PImage wizardIcon;
PImage blobIcon;
PImage ogreIcon;
PImage minotaur1Icon;
PImage minotaur2Icon;
PImage treasureIcon;
PImage potionIcon;
PImage trapIcon;
PImage portalIcon;
PImage entranceIcon;
PImage exitIcon;

char[][][] maps = {{{'m', '.', 'w', '#', '.', '.', 'b', 'x'},
                    {'.', '#', '.', 'o', '.', '#', '.', 'b'},
                    {'.', '.', '.', '#', '.', '.', '#', '.'},
                    {'.', '#', 'p', '.', 'g', '#', 'p', '.'},
                    {'.', '.', '#', 'r', '.', '.', '#', '.'},
                    {'.', '#', '.', '#', '.', '.', '#', '.'},
                    {'.', 'p', '.', '#', '1', '#', '.', 'p'},
                    {'.', '#', '.', '.', '#', '.', '.', '#'},
                    {'.', '.', '#', '#', '#', '.', '.', '.'},
                    {'.', '#', 'r', 'r', '.', '#', '.', '.'},
                    {'.', '#', '.', '#', '.', '#', '.', '.'},
                    {'.', 'o', '#', '.', 'g', '2', '#', '.'},
                    {'r', '.', '.', '.', '#', 'p', 'w', '.'},
                    {'.', '#', '.', '#', '.', '.', '#', '.'},
                    {'.', 't', 'g', '#', '#', '.', '.', '.'},
                    {'.', '#', '.', '#', 'r', '.', '#', '.'},
                    {'.', '.', '.', '.', '#', '.', '.', '.'},
                    {'e', '.', '#', '.', '.', '.', '#', 'm'}}};
                    
int[] portal1y = {6};
int[] portal1x = {4};
int[] portal2y = {11};
int[] portal2x = {5};
                    
void setup(){
  
  //set map size
  size(400, 800);
  
  //load images
  heroIcon = loadImage("../hero.jpg");
  goblinIcon = loadImage("../goblin.jpg");
  wizardIcon = loadImage("../wizard.jpg");
  blobIcon = loadImage("../blob.png");
  ogreIcon = loadImage("../ogre.png");
  minotaur1Icon = loadImage("../minotaur1.png");
  minotaur2Icon = loadImage("../minotaur2.png");
  treasureIcon = loadImage("../treasure.jpg");
  potionIcon = loadImage("../potion.png");
  trapIcon = loadImage("../trap.jpg");
  portalIcon = loadImage("../portal.jpg");
  entranceIcon = loadImage("../entrance.jpg");
  exitIcon = loadImage("../exit.jpg");
  
  //resize images
  heroIcon.resize(tile, tile);
  goblinIcon.resize(tile, tile);
  wizardIcon.resize(tile, tile);
  ogreIcon.resize(tile, tile);
  minotaur1Icon.resize(tile, tile);
  minotaur2Icon.resize(tile, tile);
  treasureIcon.resize(tile, tile);
  potionIcon.resize(tile, tile);   
  trapIcon.resize(tile, tile);
  portalIcon.resize(tile, tile);
  entranceIcon.resize(tile, tile);
  exitIcon.resize(tile, tile);
  
  //initialize characters
  start =false;
  playAgain = false;
  goblins = new HashSet<Goblin>();
  wizards = new HashSet<Wizard>();
  blobs = new HashSet<Blob>();
  ogres = new HashSet<Ogre>();
  minotaurs = new HashSet<Minotaur>();
  treasures = new HashSet<Treasure>();
  potions = new HashSet<Potion>();
  
  if(mission < maps.length){
    for(int y = 0; y < 18; y++){
      for(int x = 0; x < 8; x++){
        switch(maps[mission][y][x]){
          case 'e' : {
            hero = new Hero(y, x, score);
            break;
          }
          case 'g' : {
            goblins.add(new Goblin(y, x));
            break;
          }
          case 'w' : {
            wizards.add(new Wizard(y, x));
            break;
          }
          case 'b' : {
            blobs.add(new Blob(y, x, 1));
            break;
          }
          case 'o' : {
            ogres.add(new Ogre(y, x));
            break;
          }
          case 'm' : {
            minotaurs.add(new Minotaur(y, x));
            break;
          }
          case 'r' : {
            treasures.add(new Treasure(y, x));
            break;
          }
          case 'p' : {
            potions.add(new Potion(y, x));
            break;
          }
          default :   
        }
      }
    }
  }
  PFont f;
  f = createFont("Arial", 16, true);
  stroke(255);
  strokeWeight(5);
  fill(255, 0, 0);
  textFont(f, 16);
  textAlign(CENTER);
}

void draw(){
  background(0);
   
  if(!start){ //draw opening screen
    if(mission < maps.length){
      if(playAgain){
        text("Game Over", width/2, height/2);
        score = 0;
      } else {
        text("Mini Dungeon 2", width/2, height/2);
        text("Mission " + mission, width/2, height/2 + tile);
      }
      if(keyPressed && key == ENTER){
        setup();
      }
    }else {
      text("Mini Dungeon 2", width/2, height/2);
      text("Congratulations! All missions are completed.", width/2, height/2 + tile);
      if(keyPressed && key == ENTER){
        mission = 0;
        setup();
      }
    }
    text("Click Enter to start", width/2, height/2+2*tile);
  }
  
  else{ // draw runtime screen
    stroke(255);
    strokeWeight(1);
    fill(220);
    rectMode(CORNER);
    rect(tile, tile, width - tile*2, height - tile*2);
    
    //draw tiles, entrance, exit, traps and portals;
    for(int y = 0; y < 18; y++){
      for(int x = 0; x < 8; x++){
        switch(maps[mission][y][x]){
          case '#' : {
            fill(0);
            rect(x*tile+tile, y*tile+tile, tile, tile);
            break;
          }
          case 'e' : {            
            image(entranceIcon, x*tile + tile, y*tile + tile);
            break;
          }
          case 'x' : {            
            image(exitIcon, x*tile + tile, y*tile + tile);
            break;
          }
          case 't' : {            
            image(trapIcon, x*tile + tile, y*tile + tile);
            break;
          }
          case '1' :
          case '2': {            
            image(portalIcon, x*tile + tile, y*tile + tile);
            break;
          }
          default : {
            fill(220);
             rect(x*tile+tile, y*tile+tile, tile, tile);
          }
        }        
      }
    }
    
    //draw potions and treasures
    for(Potion p : potions){
      p.display();
    }
    for(Treasure t : treasures){
      t.display();
    }
    
    //draw goblins, wizards, blobs, ogres, minotaurs and the hero
    for(Goblin g : goblins){
      g.display();
    }
    for(Wizard w : wizards){
      w.display();
    }
    for(Blob b : blobs){
      b.display();
    }
    for(Ogre o : ogres){
      o.display();
    }
    for(Minotaur m : minotaurs){
      m.display();
    }
    hero.display();
    
    //show hero HP and score;
    fill(255, 0, 0);
    text("HP : " + hero.HP, tile * 2, height - tile/2);
    text("Score : " + hero.score, width/2, height - tile/2);
  }
}

void keyReleased(){
  if(key == CODED){
    boolean moved = false;
    if(keyCode == LEFT){
      moved = hero.move(1);
    }
    else if(keyCode == RIGHT){
      moved = hero.move(2);
    }
    else if(keyCode == UP){
      moved = hero.move(3);
    }
    else if(keyCode == DOWN){
      moved = hero.move(4);
    }    
    if(moved){
      for(Goblin g : goblins){
        if(g.y < 0 || g.x < 0) continue;
        g.move();
      }
      for(Wizard w : wizards){
        if(w.y < 0 || w.x < 0) continue;
        w.move();
      }
      for(Blob b : blobs){
        System.out.println(tile * (b.attack+1) / 4 + " " + tile * (b.attack+1) / 4);
        if(b.y < 0 || b.x < 0) continue;
        b.move();
      }
      for(Ogre o : ogres){
        if(o.y < 0 || o.x < 0) continue;
        o.move();
      }
      for(Minotaur m : minotaurs){
        m.move();
      }
    }
  }

  if(keyCode == ENTER && !start){
    start = true;
  }
}

class Hero{
  int y;
  int x;
  int HP;
  int score;
  int attack;
  Hero(int y, int x, int score){
    this.y = y;
    this.x = x;
    this.HP = 10;
    this.score = score;
    this.attack = 1;
  }
  void display(){
    image(heroIcon, x*tile + tile, y*tile + tile);
  }
  boolean move(int n){ // 1: left  2: right   3:up   4:down
    int i = -1, j = -1;
    switch(n){
      case 1 : {i = y; j = x - 1; break;}
      case 2 : {i = y; j = x + 1; break;}
      case 3 : {i = y - 1; j = x; break;}
      case 4 : {i = y + 1; j = x; break;}
      default :
    }
    if(mission >= maps.length || i < 0 || i > 17 || j < 0 || j > 7 || maps[mission][i][j] == '#'){
      return false;
    }
    if(maps[mission][i][j] == 'x'){      
      start = false;
      playAgain = false;
      mission++;
      return false;
    }
    if(maps[mission][i][j] == '1'){
      y = portal2y[mission];
      x = portal2x[mission];
      return true;
    }
    if(maps[mission][i][j] == '2'){
      y = portal1y[mission];
      x = portal1x[mission];
      return true;
    }
    
    for(Treasure t : treasures){
      if(t.isAt(i, j)){
        collideWith(t);
        break;
      }
    }
    for(Potion p : potions){
      if(p.isAt(i, j)){
        collideWith(p);
        break;
      }
    }
    for(Goblin g : goblins){
      if(g.isAt(i, j)){
        collideWith(g);
        return true;
      }
    }
    for(Wizard w : wizards){
      if(w.isAt(i, j)){
        collideWith(w);
        return true;
      }
    }
    for(Blob b : blobs){
      if(b.isAt(i, j)){
        collideWith(b);
        return true;
      }
    }
    for(Ogre o : ogres){
      if(o.isAt(i, j)){
        collideWith(o);
        return true;
      }
    }
    for(Minotaur m : minotaurs){
      if(m.isAt(i, j)){
        collideWith(m);
        return true;
      }
    }
    if(maps[mission][i][j] == 't'){      
      getHurt(1);
    }
    y = i;
    x = j;
    return true;
  }
  boolean isAt(int y, int x){
    return this.y == y && this.x == x;
  }
  void getHurt(int n){
    HP -= n;
    if(HP < 1){
      start = false;
      playAgain = true;
    }
  }
  void collideWith(Treasure t){
    score += t.reward;
    y = t.y;
    x = t.x;
    t.getHurt();
  }
  void collideWith(Potion p){
    HP += p.heal;
    if(HP > 10) HP = 10;
    y = p.y;
    x = p.x;
    p.getHurt();
  }
  void collideWith(Goblin g){
    getHurt(g.attack);
    y = g.y;
    x = g.x;
    g.getHurt();
  }
  void collideWith(Wizard w){
    y = w.y;
    x = w.x;
    w.getHurt();
  }
  void collideWith(Blob b){
    getHurt(b.attack);
    b.HP -= attack;
    if(b.HP < 1){
      y = b.y;
      x = b.x;
      b.y = -2;
      b.x = -2;
    }
  }
  void collideWith(Ogre o){
    getHurt(o.attack);
    o.HP -= attack;
    if(o.HP < 1){
      y = o.y;
      x = o.x;
      o.y = -2;
      o.x = -2;
    }
  }
  void collideWith(Minotaur m){
    getHurt(m.attack);
    m.getHurt();
  }  
}

class Goblin{
  int y;
  int x;
  int HP;
  int attack;
  Goblin(int y, int x){
    this.y = y;
    this.x = x;
    this.HP = 1;
    this.attack = 1;
  }
  void display(){
    image(goblinIcon, x*tile + tile, y*tile + tile);
  }
  boolean isAt(int y, int x){
    return this.y == y && this.x == x;
  }
  void getHurt(){
    y = -2;
    x = -2;
  }
  void move(){
    if(y < 0 || x < 0) return;
    if(y != hero.y && x != hero.x){
      return;
    }
    if(y == hero.y){
      for(int i = Math.min(x, hero.x) + 1; i < Math.max(x, hero.x); i++){
        if(maps[mission][y][i] == '#') return;
      }
      if(x < hero.x && noGoblinOrWizard(y, x+1)) x++;
      else if(x > hero.x && noGoblinOrWizard(y, x-1)) x--;
    }
    else if(x == hero.x){
      for(int i = Math.min(y, hero.y) + 1; i < Math.max(y, hero.y); i++){
        if(maps[mission][i][x] == '#') return;
      }
      if(y < hero.y && noGoblinOrWizard(y+1, x)) y++;
      else if(y > hero.y && noGoblinOrWizard(y-1, x)) y--;
    }
    if(maps[mission][y][x] == '1'){
      y = portal2y[mission];
      x = portal2x[mission];
      return;
    }
    if(maps[mission][y][x] == '2'){
      y = portal1y[mission];
      x = portal1x[mission];
      return;
    }
    if(maps[mission][y][x] == 't'){
      getHurt();
    }
    if(hero.isAt(y, x)){
      hero.getHurt(attack);
      getHurt();
    }
    for(Blob b : blobs){
      if(b.isAt(y, x)){
        getHurt();
        b.getHurt(attack);
      }
    }
    for(Ogre o : ogres){
      if(o.isAt(y, x)){
        getHurt();
        o.getHurt(attack);
      }
    }
    for(Minotaur m : minotaurs){
      if(m.isAt(y, x)){
        getHurt();
        m.getHurt();
      }
    }
  }
}

class Wizard{
  int y;
  int x;
  int HP;
  int attack;
  Wizard(int y, int x){
    this.y = y;
    this.x = x;
    this.HP = 1;
    this.attack = 1;
  }
  void display(){
    image(wizardIcon, x*tile + tile, y*tile + tile);
  }
  boolean isAt(int y, int x){
    return this.y == y && this.x == x;
  }
  void getHurt(){
    y = -2;
    x = -2;
  }
  void move(){
    if(y < 0 || x < 0) return;
    if(y != hero.y && x != hero.x){
      return;
    }
    if(y == hero.y){
      for(int i = Math.min(x, hero.x) + 1; i < Math.max(x, hero.x); i++){
        if(maps[mission][y][i] == '#') return;
      }
      if(Math.abs(x - hero.x) <= 5) hero.getHurt(attack);
      else if(x < hero.x && noGoblinOrWizard(y, x+1)) x++;
      else if(x > hero.x && noGoblinOrWizard(y, x-1)) x--;
    }
    else if(x == hero.x){
      for(int i = Math.min(y, hero.y) + 1; i < Math.max(y, hero.y); i++){
        if(maps[mission][i][x] == '#') return;
      }
      if(Math.abs(y - hero.y) <= 5) hero.getHurt(attack);
      else if(y < hero.y && noGoblinOrWizard(y+1, x)) y++;
      else if(y > hero.y && noGoblinOrWizard(y-1, x)) y--;
    }
    if(maps[mission][y][x] == '1'){
      y = portal2y[mission];
      x = portal2x[mission];
      return;
    }
    if(maps[mission][y][x] == '2'){
      y = portal1y[mission];
      x = portal1x[mission];
      return;
    }
    if(maps[mission][y][x] == 't'){
      getHurt();
    }
    if(hero.isAt(y, x)){
      getHurt();
    }
    for(Blob b : blobs){
      if(b.isAt(y, x)) getHurt();
    }
    for(Ogre o : ogres){
      if(o.isAt(y, x)) getHurt();
    }
    for(Minotaur m : minotaurs){
      if(m.isAt(y, x)) getHurt();
    }
  }
}

class Blob{
  int y;
  int x;
  int HP;
  int attack;
  Blob(int y, int x, int level){
    this.y = y;
    this.x = x;
    this.HP = level;
    this.attack = level;
  }
  void display(){
    imageMode(CENTER);
    blobIcon.resize(tile * (attack+1) / 4, tile * (attack+1) / 4);
    image(blobIcon, x*tile + tile*1.5, y*tile + tile*1.5);
    imageMode(CORNER);
  }
  boolean isAt(int y, int x){
    return this.y == y && this.x == x;
  }
  void getHurt(int n){
    HP -= n;
    attack -= n;
    if(HP < 1){
      y = -2;
      x = -2;
    }
  }
  void move(){
    if(y < 0 || x < 0) return;
    int aimX = -2;
    int aimY = -2;
    int closest = 20;
    for(Potion p : potions){
      if(y == p.y){
        boolean seen = true;
        for(int i = Math.min(x, p.x) + 1; i < Math.max(x, p.x); i++){
          if(maps[mission][y][i] == '#'){
            seen = false;
            break;
          }
        }
        if(seen && Math.abs(x - p.x) < closest){
          closest = Math.abs(x - p.x);
          aimX = p.x;
          aimY = p.y;
        }
      }
      else if(x == p.x){
        boolean seen = true;
        for(int i = Math.min(y, p.y) + 1; i < Math.max(y, p.y); i++){
          if(maps[mission][i][x] == '#'){
            seen = false;
            break;
          }
        }
        if(seen && Math.abs(y - p.y) < closest){
          closest = Math.abs(y - p.y);
          aimX = p.x;
          aimY = p.y;
        }
      }
    }
    if(aimX < 0){
      if(y == hero.y){
        boolean seen = true;
        for(int i = Math.min(x, hero.x) + 1; i < Math.max(x, hero.x); i++){
          if(maps[mission][y][i] == '#'){
            seen = false;
            break;
          }
        }
        if(seen && Math.abs(x - hero.x) < closest){
          closest = Math.abs(x - hero.x);
          aimX = hero.x;
          aimY = hero.y;
        }
      }
      else if(x == hero.x){
        boolean seen = true;
        for(int i = Math.min(y, hero.y) + 1; i < Math.max(y, hero.y); i++){
          if(maps[mission][i][x] == '#'){
            seen = false;
            break;
          }
        }
        if(seen && Math.abs(y - hero.y) < closest){
          closest = Math.abs(y - hero.y);
          aimX = hero.x;
          aimY = hero.y;
        }
      }
    }
    if(aimX < 0) return;
    if(y == aimY){
      if(x < aimX){
        if(!hero.isAt(y, x+1) && noMinotaur(y, x+1)) x++;
        else if(hero.isAt(y, x+1)){
          hero.getHurt(attack);
          getHurt(hero.attack);
        }
        else{
          for(Minotaur m : minotaurs){
            if(m.isAt(y, x+1)){
              m.getHurt();
              getHurt(m.attack);
            }
          }
        }
      }
      else if(x > aimX){
        if(!hero.isAt(y, x-1) && noMinotaur(y, x-1)) x--;
        else if(hero.isAt(y, x-1)){
          hero.getHurt(attack);
          getHurt(hero.attack);
        }
        else{
          for(Minotaur m : minotaurs){
            if(m.isAt(y, x+1)){
              m.getHurt();
              getHurt(m.attack);
            }
          }
        }
      }
    }
    else if(x == aimX){
      if(y < aimY){
        if(!hero.isAt(y+1, x) && noMinotaur(y+1, x)) y++;
        else if(hero.isAt(y+1, x)){
          hero.getHurt(attack);
          getHurt(hero.attack);
        }
        else{
          for(Minotaur m : minotaurs){
            if(m.isAt(y+1, x)){
              m.getHurt();
              getHurt(m.attack);
            }
          }
        }
      }
      else if(y < aimY){
        if(!hero.isAt(y-1, x) && noMinotaur(y-1, x)) y--;
        else if(hero.isAt(y-1, x)){
          hero.getHurt(attack);
          getHurt(hero.attack);
        }
        else{
          for(Minotaur m : minotaurs){
            if(m.isAt(y-1, x)){
              m.getHurt();
              getHurt(m.attack);
            }
          }
        }
      }
    }
    if(y < 0 || x < 0) return;
    if(maps[mission][y][x] == '1'){
      y = portal2y[mission];
      x = portal2x[mission];
      return;
    }
    if(maps[mission][y][x] == '2'){
      y = portal1y[mission];
      x = portal1x[mission];
      return;
    }
    if(maps[mission][y][x] == 't'){
      getHurt(1);
    }
    for(Potion p : potions){
      if(p.isAt(y, x)){
        p.getHurt();
      }
    }
    for(Goblin g : goblins){
      if(g.isAt(y, x)){
        g.getHurt();
        getHurt(g.attack);        
      }
    }
    for(Wizard w : wizards){
      if(w.isAt(y, x)){
        w.getHurt();
      }
    }
    for(Blob b : blobs){
      if(!b.equals(this) && b.isAt(y, x)){
        b.y = -2;
        b.x = -2;
        HP = Math.min(3, Math.max(HP, b.HP) + 1);
        attack = Math.min(3, Math.max(attack, b.attack) + 1);
      }
    }
    for(Ogre o : ogres){
      if(o.isAt(y, x)){        
        o.getHurt(attack);
        getHurt(o.attack);
      }
    }    
  }
}

class Ogre{
  int y;
  int x;
  int HP;
  int attack;
  Ogre(int y, int x){
    this.y = y;
    this.x = x;
    this.HP = 2;
    this.attack = 2;
  }
  void display(){
    image(ogreIcon, x*tile + tile, y*tile + tile);
  }
  boolean isAt(int y, int x){
    return this.y == y && this.x == x;
  }
  void getHurt(int n){
    HP -= n;
    if(HP < 1){
      y = -2;
      x = -2;
    }
  }
  void move(){
    if(y < 0 || x < 0) return;
    int aimX = -2;
    int aimY = -2;
    int closest = 20;
    for(Treasure t : treasures){
      if(y == t.y){
        boolean seen = true;
        for(int i = Math.min(x, t.x) + 1; i < Math.max(x, t.x); i++){
          if(maps[mission][y][i] == '#'){
            seen = false;
            break;
          }
        }
        if(seen && Math.abs(x - t.x) < closest){
          closest = Math.abs(x - t.x);
          aimX = t.x;
          aimY = t.y;
        }
      }
      else if(x == t.x){
        boolean seen = true;
        for(int i = Math.min(y, t.y) + 1; i < Math.max(y, t.y); i++){
          if(maps[mission][i][x] == '#'){
            seen = false;
            break;
          }
        }
        if(seen && Math.abs(y - t.y) < closest){
          closest = Math.abs(y - t.y);
          aimX = t.x;
          aimY = t.y;
        }
      }
    }
    if(aimX < 0){
      if(y == hero.y){
        boolean seen = true;
        for(int i = Math.min(x, hero.x) + 1; i < Math.max(x, hero.x); i++){
          if(maps[mission][y][i] == '#'){
            seen = false;
            break;
          }
        }
        if(seen && Math.abs(x - hero.x) < closest){
          closest = Math.abs(x - hero.x);
          aimX = hero.x;
          aimY = hero.y;
        }
      }
      else if(x == hero.x){
        boolean seen = true;
        for(int i = Math.min(y, hero.y) + 1; i < Math.max(y, hero.y); i++){
          if(maps[mission][i][x] == '#'){
            seen = false;
            break;
          }
        }
        if(seen && Math.abs(y - hero.y) < closest){
          closest = Math.abs(y - hero.y);
          aimX = hero.x;
          aimY = hero.y;
        }
      }
    }
    if(aimX < 0) return;
    if(y == aimY){
      if(x < aimX){
        if(!hero.isAt(y, x+1) && noMinotaur(y, x+1)) x++;
        else if(hero.isAt(y, x+1)){
          hero.getHurt(attack);
          getHurt(hero.attack);
        }
        else{
          for(Minotaur m : minotaurs){
            if(m.isAt(y, x+1)){
              m.getHurt();
              getHurt(m.attack);
            }
          }
        }
      }
      else if(x > aimX){
        if(!hero.isAt(y, x-1) && noMinotaur(y, x-1)) x--;
        else if(hero.isAt(y, x-1)){
          hero.getHurt(attack);
          getHurt(hero.attack);
        }
        else{
          for(Minotaur m : minotaurs){
            if(m.isAt(y, x+1)){
              m.getHurt();
              getHurt(m.attack);
            }
          }
        }
      }
    }
    else if(x == aimX){
      if(y < aimY){
        if(!hero.isAt(y+1, x) && noMinotaur(y+1, x)) y++;
        else if(hero.isAt(y+1, x)){
          hero.getHurt(attack);
          getHurt(hero.attack);
        }
        else{
          for(Minotaur m : minotaurs){
            if(m.isAt(y+1, x)){
              m.getHurt();
              getHurt(m.attack);
            }
          }
        }
      }
      else if(y < aimY){
        if(!hero.isAt(y-1, x) && noMinotaur(y-1, x)) y--;
        else if(hero.isAt(y-1, x)){
          hero.getHurt(attack);
          getHurt(hero.attack);
        }
        else{
          for(Minotaur m : minotaurs){
            if(m.isAt(y-1, x)){
              m.getHurt();
              getHurt(m.attack);
            }
          }
        }
      }
    }
    if(y < 0 || x < 0) return;
    if(maps[mission][y][x] == '1'){
      y = portal2y[mission];
      x = portal2x[mission];
      return;
    }
    if(maps[mission][y][x] == '2'){
      y = portal1y[mission];
      x = portal1x[mission];
      return;
    }
    if(maps[mission][y][x] == 't'){
      getHurt(1);
    }
    for(Treasure t : treasures){
      if(t.isAt(y, x)){
        t.getHurt();
      }
    }
    for(Goblin g : goblins){
      if(g.isAt(y, x)){
        getHurt(g.attack);
        g.getHurt();
      }
    }
    for(Wizard w : wizards){
      if(w.isAt(y, x)){
        w.getHurt();
      }
    }
    for(Blob b : blobs){
      if(b.isAt(y, x)){
        getHurt(b.attack);
        b.getHurt(attack);
      }
    }
    for(Ogre o : ogres){
      if(!o.equals(this) && o.isAt(y, x)){
        getHurt(o.attack);
        o.getHurt(attack);
      }
    }
  }
}

class Minotaur{
  int y;
  int x;
  int knocked;
  int attack;
  Minotaur(int y, int x){
    this.y = y;
    this.x = x;
    this.knocked = 0;
    this.attack = 1;
  }
  void display(){
    if(knocked > 0){
      image(minotaur1Icon, x*tile + tile, y*tile + tile);
    } else {
      image(minotaur2Icon, x*tile + tile, y*tile + tile);
    }
  }
  boolean isAt(int y, int x){
    return this.y == y && this.x == x;
  }
  void getHurt(){
    knocked = 3;
  }
  void move(){
    if(knocked > 0){
      knocked--;
      return;
    }
    if(maps[mission][y][x] == 't'){
      getHurt();
      return;
    }
    int[] aim = findPath(this);
    boolean collided = false;
    if(hero.isAt(aim[0], aim[1])){
      hero.getHurt(attack);
      getHurt();
      collided = true;
    }
    if(maps[mission][y][x] == '1'){
      y = portal2y[mission];
      x = portal2x[mission];
      return;
    }
    if(maps[mission][y][x] == '2'){
      y = portal1y[mission];
      x = portal1x[mission];
      return;
    }
    
    for(Goblin g : goblins){
      if(g.isAt(aim[0], aim[1])){
        y = g.y;
        x = g.x;
        g.getHurt();
        getHurt();
        collided = true;
      }
    }
    for(Wizard w : wizards){
      if(w.isAt(aim[0], aim[1])){
        y = w.y;
        x = w.x;
        w.getHurt();
        collided = true;
      }
    }
    for(Blob b : blobs){
      if(b.isAt(aim[0], aim[1])){
        b.HP -= attack;
        if(b.HP < 0){
          y = b.y;
          x = b.x;
          b.y = -2;
          b.x = -2;
          getHurt();
          collided = true;
        }
      }
    }
    for(Ogre o : ogres){
      if(o.isAt(aim[0], aim[1])){
        o.HP -= attack;
        if(o.HP < 0){
          y = o.y;
          x = o.x;
          o.y = -2;
          o.x = -2;
          getHurt();
          collided = true;
        }
      }
    }
    if(!collided){
      y = aim[0];
      x = aim[1];
    }
  }    
}

class Treasure{
  int y;
  int x;
  int reward;
  Treasure(int y, int x){
    this.y = y;
    this.x = x;
    this.reward = 20;
  }
  void display(){
    image(treasureIcon, x*tile + tile, y*tile + tile);
  }
  boolean isAt(int y, int x){
    return this.y == y && this.x == x;
  }
  void getHurt(){
    y = -2;
    x = -2;
  }
}

class Potion{
  int y;
  int x;
  int heal;
  Potion(int y, int x){
    this.y = y;
    this.x = x;
    this.heal = 1;
  }
  void display(){
    image(potionIcon, x*tile + tile, y*tile + tile);
  }
  boolean isAt(int y, int x){
    return this.y == y && this.x == x;
  }
  void getHurt(){
    y = -2;
    x = -2;
  }
}

boolean noGoblinOrWizard(int y, int x){
  for(Goblin g : goblins){
    if(g.isAt(y, x)){
      return false;
    }
  }
  for(Wizard w : wizards){
    if(w.isAt(y, x)){
      return false;
    }
  }
  return true;
}

boolean noMinotaur(int y, int x){
  for(Minotaur m : minotaurs){
    if(m.isAt(y, x)){
      return false;
    }
  }
  return true;
}

int[][] DIREC = {{-1, 0}, {1, 0}, {0, 1}, {0, -1}};

//+--------------------------------------------------+
//| A* Algorithm to determine movements of minotaurs |
//+--------------------------------------------------+

int[] findPath(Minotaur m){
  List<Position> openList = new ArrayList<Position>();
  List<Position> closeList = new ArrayList<Position>();
  boolean findFlag = false;
  Position termPos = null;
  
  Position startPos = new Position(m.y, m.x, calcH(m.y, m.x, hero.y, hero.x));
  openList.add(startPos);
  
  do{
    Position currentPos = openList.get(0);
    for (int i = 0; i < openList.size(); i++) {
      if (currentPos.F > openList.get(i).F) {
        currentPos = openList.get(i);
      }
    }
    closeList.add(currentPos);
    openList.remove(currentPos);
    
    for (int i = 0; i < DIREC.length; i++) {
      int tmpY = currentPos.row + DIREC[i][0];
      int tmpX = currentPos.col + DIREC[i][1];
      if (tmpY < 0 || tmpY >= maps[mission].length || tmpX < 0 || tmpX >= maps[mission][0].length)
        continue;
      
      Position tmpPos = new Position(tmpY, tmpX, calcH(tmpY, tmpX, hero.y, hero.x), currentPos);
      if(maps[mission][tmpY][tmpX] == '#' || closeList.contains(tmpPos))
        continue;
      if(!openList.contains(tmpPos))
        openList.add(tmpPos);
      else{
        Position prePos = null;
        for (Position pos : openList) {
          if (pos.row == tmpY && pos.col == tmpX) {
            prePos = pos;
            break;
          }
        }
        if(tmpPos.G < prePos.G)
          prePos.setFaPos(currentPos);
      }
    }
    
    for(Position tpos : openList){
      if(tpos.row == hero.y && tpos.col == hero.x){
        termPos = tpos;
        findFlag = true;
        break;
      }
    }
  }while(openList.size() > 0);
  
  if(!findFlag){
    System.out.println("no valid path!");
    return new int[2];
  }
  if(termPos != null){
    while(termPos.fa.fa != null){
      termPos = termPos.fa;
    }
  }
//  System.out.println("("+termPos.row+", "+termPos.col+")");
  return new int[]{termPos.row, termPos.col};     
}

int calcH(int y, int x, int ty, int tx){
  int diff = Math.abs(x - tx) + Math.abs(y - ty);
  return diff * 10;
}

class Position{
  int F;
  int G;
  int H;
  Position fa;
  int row;
  int col;
  
  Position(){}
  
  Position(int row, int col, int H){
    this(row, col, H, null);
  }
  
  Position(int row, int col, int H, Position pos){
    this.H = H;
    this.row = row;
    this.col = col;
    this.fa = pos;
    this.G = calcG();
    this.F = G + H;
  }
  
  int calcG(){
    if(fa == null) return 0;
    if(fa.row != this.row && fa.col != this.col) return 14 + fa.G;
    return 10 + fa.G;
  }
  
  void setFaPos(Position pos){
    this.fa = pos;
    this.G = calcG();
    this.F = G + H;
  }
  
  boolean equals(Object obj){
    if(obj == null) return false;
    if(!(obj instanceof Position)) return false;
    Position pos = (Position)obj;
    return this.row == pos.row && this.col == pos.col;
  }
  
  int hashCode(){
    int prime = 31;
    int result = 1;
    result = prime * result + row;
    result = prime * result + col;
    return result;
  }
}

    
  