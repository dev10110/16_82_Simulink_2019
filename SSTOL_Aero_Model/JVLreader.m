clear all
i=0;
for df=[-2 6 15]
    for cj=[0 3 6]
        i=i+1;
        text=fileread(strcat('cj_',num2str(cj),'_df_',num2str(df),'.out'));
        str=extractAfter(text,'CLq =');
        CLq(i)=str2num(str(1:12));
        
        str=extractAfter(text,'Cmq =');
        Cmq(i)=str2num(str(1:12));
        
        str=extractAfter(text,'CLd3 =');
        CLde(i)=str2num(str(1:12));
        
        str=extractAfter(text,'Cmd3 =');
        Cmde(i)=str2num(str(1:12));
        
        str=extractAfter(text,'CYb =');
        CYB(i)=str2num(str(1:12));
        
        str=extractAfter(text,'Clb =');
        ClB(i)=str2num(str(1:12));
        
        str=extractAfter(text,'Cnb =');
        CnB(i)=str2num(str(1:12));
        
        str=extractAfter(text,'CYd2 =');
        CYdA(i)=str2num(str(1:12));
        
        str=extractAfter(text,'CYd4 =');
        CYdR(i)=str2num(str(1:12));
        
        str=extractAfter(text,'Cld2 =');
        CldA(i)=str2num(str(1:12));
        
        str=extractAfter(text,'Cld4 =');
        CldR(i)=str2num(str(1:12));
        
        str=extractAfter(text,'Cnd2 =');
        CndA(i)=str2num(str(1:12));
        
        str=extractAfter(text,'Cnd4 =');
        CndR(i)=str2num(str(1:12));
        
        str=extractAfter(text,'CYr =');
        CYr(i)=str2num(str(1:12));
        
        str=extractAfter(text,'CYp =');
        CYp(i)=str2num(str(1:12));
        
        str=extractAfter(text,'Clr =');
        Clr(i)=str2num(str(1:12));
        
        str=extractAfter(text,'Clp =');
        Clp(i)=str2num(str(1:12));
        
        str=extractAfter(text,'Cnr =');
        Cnr(i)=str2num(str(1:12));
        
        str=extractAfter(text,'Cnp =');
        Cnp(i)=str2num(str(1:12));
    end
end

df_fit=[0 0 0 20 20 20 40 40 40]';
cj_fit=[0 3 6 0 3 6 0 3 6]';


A.f_ClB=coeffvalues(fit([df_fit cj_fit], ClB','poly11'));
A.f_CldA=coeffvalues(fit([df_fit cj_fit], CldA','poly11'));
A.f_CLde=coeffvalues(fit([df_fit cj_fit], CLde','poly11'));
A.f_CldR=coeffvalues(fit([df_fit cj_fit], CldR','poly11'));
A.f_Clp=coeffvalues(fit([df_fit cj_fit], Clp','poly11'));
A.f_CLq=coeffvalues(fit([df_fit cj_fit], CLq','poly11'));
A.f_Clr=coeffvalues(fit([df_fit cj_fit], Clr','poly11'));
A.f_Cmde=coeffvalues(fit([df_fit cj_fit], Cmde','poly11'));
A.f_Cmq=coeffvalues(fit([df_fit cj_fit], Cmq','poly11'));
A.f_CnB=coeffvalues(fit([df_fit cj_fit], CnB','poly11'));
A.f_CndA=coeffvalues(fit([df_fit cj_fit], CndA','poly11'));
A.f_Cnp=coeffvalues(fit([df_fit cj_fit], Cnp','poly11'));
A.f_Cnr=coeffvalues(fit([df_fit cj_fit], Cnr','poly11'));
A.f_CYB=coeffvalues(fit([df_fit cj_fit], CYB','poly11'));
A.f_CYdA=coeffvalues(fit([df_fit cj_fit], CYdA','poly11'));
A.f_CYdR=coeffvalues(fit([df_fit cj_fit], CYdR','poly11'));
A.f_CYp=coeffvalues(fit([df_fit cj_fit], CYp','poly11'));
A.f_CYr=coeffvalues(fit([df_fit cj_fit], CYr','poly11'));
A.f_CndR=coeffvalues(fit([df_fit cj_fit], CndR','poly11'));
save('f_JVLderivatives.mat','A');
