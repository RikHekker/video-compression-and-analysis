clear all; close all;
load_test;

%get the data in a useful shape
for data=1:size(test_digits,3)*0.5
    train_data(data,:)=sum(test_digits(:,:,data),2);
    for state=1:size(test_digits,2)
        sorted_data(test_labels(data)+1,data,state)=train_data(data,state);
    end
end

%train the HMMs
for label=1:10
    for state=1:size(test_digits,2)
        avg(label,state)=sum(sorted_data(label,:,state))/size(test_digits,2);
        variance(label,state)=std(sorted_data(label,:,state));
    end
end

%classify the new data
error=0;
confusion=zeros(10,10);
for data=1:size(test_digits,3)*0.5%size(test_digits,3):size(test_digits,3)
    test_data(data,:)=sum(test_digits(:,:,data+5000),2);
    for label=1:10
        for state=1:size(test_digits,2)
            if variance(label,state)==0
                prob(data,label,state)=1;
            else
                prob(data,label,state)=1/(2*pi*variance(label,state))*exp(-(test_data(data,state)-mean(label,state)).^2/(2*variance(label,state)^2));
                %prob(data,label,state)=normpdf(test_data(data,state),avg(label,state),variance(label,state));
            end
        end
        chance(data,label)=prod(prob(data,label,:));
    end
    [prob_label(data),HMM_label(data)]=max(chance(data,:));
    if HMM_label(data)-1 ~=test_labels(data+5000)
        error=error+1;
    end
    confusion(HMM_label(data),test_labels(data+5000)+1)=confusion(HMM_label(data),test_labels(data+5000)+1)+1;
end

error_rate=error/5000;



        