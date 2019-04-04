clear all; close all;
load_test;
for i=1:size(test_digits,3)
    row(i,:)=sum(test_digits(:,:,i),2);
end

transition=rand(10,10)