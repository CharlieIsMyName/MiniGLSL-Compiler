{
   vec4 fCol = gl_color;
   vec4 fTex = gl_TexCoord;
   vec4 eyeNorm;
   vec4 coeff;
   vec4 shade;
   const vec4 lVec = env1;
   const vec4 lHalf = gl_Light_Half;
   const vec4 red = vec4(1.0,0.0,0.0,1.0);
   eyeNorm = fTex;
   eyeNorm[3] = dp3(eyeNorm,eyeNorm);
   eyeNorm[3] = rsq(eyeNorm[3]);
   eyeNorm = eyeNorm * eyeNorm[3];
   shade = gl_Light_Ambient * fCol;
   coeff[0] = dp3(lVec,eyeNorm);
   coeff[1] = dp3(lHalf,eyeNorm);
   coeff[3] = gl_Material_Shininess[0];
   coeff = lit(coeff);
   shade = shade + coeff[1] * fCol;
   shade = shade + coeff[2] * fCol;
   gl_FragColor = shade;
   a=-123;
   b=-103.52;
   bcs = 0.3
   int dp3(ivec3,ivec3);
   abs = 3;
   
   dasd = *0.4;
   
   ivec 385.0;
   
   vec _string;
1<3;
1<da;
	0;
	float lol 1.23;
	
	
	lol.stupid;
	lol4.78
	1my_identifier0123
	3.0_thisIDT
	1...abc
	1.ab.0;



	1.0ab;
	1.ab;	
	"idf"
	3_
	1_ab;
	1.0fdasf3.0;
 	1dasvec2;
	vec 00;
	sb = 5E8; k=-139081209381239810923801928309182309810923812348712348917324098712340891723408917324078.01 aasdfjhadsfkjahsdfkjahsdflkjadshflakjdsfhlkjhasdflkjahsdfljkhadsflkjhasdkfjh=91827238472349827349827349723498723497234987987
	
}



