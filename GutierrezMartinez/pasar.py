def main():
    tabla=input().strip()
    at=input().strip()
    val=[]
    ent=input().strip().split()
    while ent!=[]:
        for e in range(len(ent)):
            ent[e]="'"+ent[e]+"'"
        ent=str(ent).replace('"','').replace("[","").replace("]","")
        val.append(ent)
        ent=input().strip().split()
    for j in range(len(val)):
        print("INSERT INTO "+tabla+"("+ at +")" +" VALUES("+val[j]+");")
main()
                   
