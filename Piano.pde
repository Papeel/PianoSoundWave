import ddf.minim.*;
import ddf.minim.ugens.*;
import java.util.*;
Minim minim;

AudioOutput out;
Map<String, String> notas = new HashMap<String, String>();
Map<Integer, String> teclas = new HashMap<Integer, String>();
PShape obj;
float posx, posy, posz;
int[][]colores= {{255,0,0},{0,255,0},{0,0,255},{255,255,0},{0,255,255},{255,0,255},{180,0,10},{45,0,180},{45,150,180},{150,45,180},{180,150,45},{150,180,45},{120,120,120}};
boolean intro = true;
String text = "Toca tu piano con las teclas del ordenador!!\n 'q'=do5, 'a'= reb5, 'w'=re5, 's'=mib5, 'e'=mi5\n'r'=fa5, 'f'=solb5, 't'=sol5, 'g'=lab5, 'y'=la5\n'h'=sib5, 'u'=si5, 'i'=do6 \nToca la tecla right o left para mover la camara\nPress enter para jugar";
int r,g,b;

void setup()
{
  noStroke();
  size(800, 800, P3D);
  notas.put("q","do5");
  notas.put("a","reb5");
  notas.put("w","re5");
  notas.put("s","mib5");
  notas.put("e","mi5");
  notas.put("r","fa5");
  notas.put("f","solb5");
  notas.put("t","sol5");
  notas.put("g","lab5");
  notas.put("y","la5");
  notas.put("h","sib5");
  notas.put("u","si5");
  notas.put("i","do6");
  teclas.put(0,"q");
  teclas.put(1,"a");
  teclas.put(2,"w");
  teclas.put(3,"s");
  teclas.put(4,"e");
  teclas.put(5,"r");
  teclas.put(6,"f");
  teclas.put(7,"t");
  teclas.put(8,"g");
  teclas.put(9,"y");
  teclas.put(10,"h");
  teclas.put(11,"u");
  teclas.put(12,"i");
  minim = new Minim(this);
  
  out = minim.getLineOut();
  
  posx = width/2.;
  posy = height/2.;
  posz = (height/2.0) / tan(PI*30.0 / 180.0);
  
  r=255;
  g=0;
  b=0;
  
}

void draw()
{
 if(intro){
   background(0);
   posx = width/2.;
   posy = height/2.;
   posz = (height/2.0) / tan(PI*30.0 / 180.0);
   camera(posx, posy,posz, width/2.0, height/2.0, 0, 0, 1, 0);
   textSize(26);
   text (text,width/5 , height/4) ;
 }else{
   
   play();
   text ("Press enter para ver instrucciones",5 , 25) ;
 }
  
 
    
}

  


void play(){
 background(0);
  pushMatrix();
  popMatrix(); 
  noLights();
  boolean luz = true;
  for(int i = 0; i<13;i++){
    if(teclas.get(i).equals(key+"")){
        pushMatrix();
        r=colores[i][0];
        g=colores[i][1];
        b=colores[i][2];
        spotLight(r,g,b,400, 400, 800, 0, 1, 0, radians(360), 0);
        popMatrix();
        luz=false;
        break;
    }
  } 
  if(luz)spotLight(r,g,b,400, 400, 800, 0, 1, 0, radians(360), 0);
    
 
  obj = createShape();
  obj.beginShape(QUAD_STRIP);
  obj.noStroke();
  //obj.vertex(0,0,0);
  for(int i =0; i < out.bufferSize() - 1; i++)
  {
    for(int j = 0; j <360; j = j+4){
      float rand = radians(j);
      obj.vertex(i*sin(rand),i*cos(rand),50 + out.left.get(i)*100);
      obj.vertex((i+1)*sin(rand),(i+1)*cos(rand), 50 + out.left.get(i+1)*100);
      
    }
    
    
     
  }
  
  obj.endShape();
  
   pushMatrix();
      noStroke();
      
      translate(400,400,0);
      shape(obj);
   popMatrix();
   
 
  
  float rad = radians(2);
  if(keyPressed && keyCode == RIGHT){
    
    float x = (posx-width/2)*cos(rad) + (posz+1200)*sin(rad);
    float z = -(posx-width/2)*sin(rad)+(posz+1200)*cos(rad);
    posx = x + width/2;
    posz = z-1200;
  }
  if(keyPressed && keyCode == LEFT){
    rad = -rad;
    float x = (posx-width/2)*cos(rad) + (posz+1200)*sin(rad);
    float z = -(posx-width/2)*sin(rad)+(posz+1200)*cos(rad);
    posx = x + width/2;
    posz = z-1200;
  }
  camera(posx, posy,posz, width/2.0, height/2.0, 0, 0, 1, 0); 
  
  
}
void keyPressed(){
  if(notas.get(key+"")!=null)thread(notas.get(key+""));if(notas.get(key+"")!=null)thread(notas.get(key+""));
  
  if(keyCode == ENTER){
    intro= !intro;
  }
  
}
void do5( ) { out.playNote( "C5" ) ; }
void reb5( ) { out.playNote( "Db5" ) ; }
void re5( ) { out.playNote( "D5" ) ; }
void mib5( ) { out.playNote( "Eb5" ) ; }
void mi5( ) { out.playNote( "E5" ) ; }
void fa5( ) { out.playNote( "F5" ) ; }
void solb5( ) { out.playNote( "Gb5" ) ; }
void sol5( ) { out.playNote( "G5" ) ; }
void lab5( ) { out.playNote( "Ab5" ) ; }
void la5( ) { out.playNote( "A5" ) ; }
void sib5( ) { out.playNote( "Bb5" ) ; }
void si5( ) { out.playNote( "B5" ) ; }
void do6( ) { out.playNote( "C6" ) ; }
