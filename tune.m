global eigenValThred
global KNN_k KNN_p
global gamma C
global tuningByUser
tuningByUser=true;

for KNN_k =[1,5,9]
    for KNN_p=[1,2,3,4,5]
        [KNN_k, KNN_p]
        trainmain;
        testmain;
    end
end