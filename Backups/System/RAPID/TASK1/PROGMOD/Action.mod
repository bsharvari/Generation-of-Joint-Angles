MODULE Action
    VAR num n_link;
    VAR num n_times;
    VAR num J1{100};
    VAR num J2{100};
    VAR num J3{100};
    VAR num J4{100};
    VAR num J5{100};
    VAR num J6{100};
    VAR num var2;
    VAR num var3;
    VAR num var5;
    VAR pos CPosition;
    VAR string position_str;
    VAR string anglesr;
    VAR jointtarget joints;


    PROC ReadingArm()
        VAR string filelocation:="arm.txt";
        VAR iodev file;
        Open filelocation,file\Read;
        n_link:=ReadNum(file\Delim:="\10");
        J1{1}:=0;
        var2:=ReadNum(file\Delim:="\10");
        J2{1}:=var2;
        var3:=ReadNum(file\Delim:="\10");
        J3{1}:=var3;
        J4{1}:=0;
        var5:=ReadNum(file);
        J5{1}:=var5;
        J6{1}:=0;
        Close file;
    ENDPROC

    PROC ReadingAng()
        VAR string filelocation:="angles.txt";
        VAR iodev file;
        Open filelocation,file\Read;
        n_times:=ReadNum(file\Delim:="\10");
        FOR count FROM 2 TO n_times+1 DO
            J1{count}:=0;
            var2:=var2+ReadNum(file\Delim:=",");
            J2{count}:=var2;
            var3:=var3+ReadNum(file\Delim:=",");
            J3{count}:=var3;
            J4{count}:=0;
            var5:=var5+ReadNum(file);
            J5{count}:=var5;
            J6{count}:=0;
        ENDFOR
        Close file;
    ENDPROC

    !a method for the the pos
    PROC pWriteSomething()
        VAR string filelocation:="out.txt";
        VAR iodev file;
        Open filelocation,file\Append;
        position_str:=NumToStr(CPosition.x,3)+","+
NumToStr(CPosition.y,3)+","+NumToStr(CPosition.z,3);
        Write file,position_str;
        Close file;
    ENDPROC

    !a method for checking the angles
    PROC WI()
        VAR string location:="wi.txt";
        VAR iodev filea;
        Open location,filea\Append;
        FOR count FROM 1 TO n_times+1 DO
            anglesr:=NumToStr(J2{count},3)+","+
NumToStr(J3{count},3)+","+NumToStr(J5{count},3);
            Write filea,anglesr;
        ENDFOR
        Close filea;

    ENDPROC

    PROC main()
        ReadingArm;
        IF n_link=3 THEN
            ReadingAng;
            WI;
            FOR count FROM 1 TO n_times+1 DO
                joints.robax.rax_1:=J1{count};
                joints.robax.rax_2:=J2{count};
                joints.robax.rax_3:=J3{count};
                joints.robax.rax_4:=J4{count};
                joints.robax.rax_5:=J5{count};
                joints.robax.rax_6:=J6{count};
                MoveAbsJ joints,v1000,fine,Tool_1\WObj:=wobj0;
                CPosition:=CPos();
                pWriteSomething;
            ENDFOR
        ENDIF
    ENDPROC
ENDMODULE