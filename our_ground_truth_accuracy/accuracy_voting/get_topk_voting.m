clear all;
close all;

% load /home/hxu1/lsda/youtube_experiment/per_frame_box_cats/vid_frame_box_cats.mat;
load /home/hxu1/lsda/youtube_experiment/per_frame_box_cats/vid_frame_box_cats_cell.mat
load /home/hxu1/lsda/data/rcnn_models/rcnn_model7200.mat;

max_top1_cell=cell(1,1970);
max_top5_cell=cell(1,1970);
max_top10_cell=cell(1,1970);

for i = 1:length(vid_frame_box_cats_cell)
    for j = 1:length(vid_frame_box_cats_cell{i})
        if length(vid_frame_box_cats_cell{i}{j}) == 0
            max_top1_cell{i}{j} = [];
            max_top5_cell{i}{j} = [];
            max_top10_cell{i}{j} = [];
        else
            [x, y]=sort(vid_frame_box_cats_cell{i}{j}(:,7),'descend');
            index = min(1,length(y));
            max_top1_cell{i}{j}=vid_frame_box_cats_cell{i}{j}(y(index),:);
            
            index=min(5,length(y));
            max_top5_cell{i}{j}=vid_frame_box_cats_cell{i}{j}(y(1:index),:);    
            
            index=min(10,length(y));
            max_top10_cell{i}{j}=vid_frame_box_cats_cell{i}{j}(y(1:index),:);
        end
    end
end

for i = 1:length(max_top10_cell)
    max_top1_cell{i} = cat(1,max_top1_cell{i}{:});
    max_top5_cell{i} = cat(1,max_top5_cell{i}{:});
    max_top10_cell{i} = cat(1,max_top10_cell{i}{:});
end

% get the topk voting catID
max_top1=cell(1,1970);
max_top5=cell(1,1970);
max_top10=cell(1,1970);

for i=1:1970
    frequency_hist = tabulate(max_top1_cell{i}(:,8));
    [x, y] = sort(frequency_hist(:,2),'descend');
    index = min(1,length(y));
    max_top1{i} = frequency_hist(y(index),1)';

    frequency_hist = tabulate(max_top5_cell{i}(:,8));
    [x, y] = sort(frequency_hist(:,2),'descend');
    index=min(5,length(y));
    max_top5{i} = frequency_hist(y(1:index),1)';    

    frequency_hist = tabulate(max_top10_cell{i}(:,8));
    [x, y] = sort(frequency_hist(:,2),'descend');
    index=min(10,length(y));
    max_top10{i} = frequency_hist(y(1:index),1)';
end

% get the corresponding topk cats
max_top1_cats=cell(1,1970);
max_top5_cats=cell(1,1970);
max_top10_cats=cell(1,1970);
for i=1:1970,
    cats_ids = max_top1{i};
    max_top1_cats{i} = rcnn_model.classes(cats_ids);    
    cats_ids = max_top5{i};
    max_top5_cats{i} = rcnn_model.classes(cats_ids);
    cats_ids = max_top10{i};
    max_top10_cats{i} = rcnn_model.classes(cats_ids);
end

% get the corresponding topk offsets
synset_words_200 = importdata(['/home/hxu1/lsda/youtube_experiment/data/synset_words_data/det_synset_words.txt']);
synset_words_7400 = importdata(['/home/hxu1/lsda/youtube_experiment/data/synset_words_data/imagenet7k_wnids_full_labels.txt']);

offsets_200 = {};
for k=1:length(synset_words_200)
        offsets_200{k} = synset_words_200{k}(1:9);
end

offsets_7400 = {};
for k=1:length(synset_words_7400)
        offsets_7400{k} = synset_words_7400{k}(1:9);
end

offsets_7600 = [offsets_200,offsets_7400];

max_top1_offsets=cell(1,1970);
max_top5_offsets=cell(1,1970);
max_top10_offsets=cell(1,1970);

for i=1:1970,
        cats_ids = max_top1{i};
        max_top1_offsets{i} = offsets_7600(cats_ids);
        cats_ids = max_top5{i};
        max_top5_offsets{i} = offsets_7600(cats_ids);
        cats_ids = max_top10{i};
        max_top10_offsets{i} = offsets_7600(cats_ids);
end


save /home/hxu1/lsda/youtube_experiment/data/accuracy_data/topk_voting/topk_cats.mat max_top1_cats max_top5_cats max_top10_cats

save /home/hxu1/lsda/youtube_experiment/data/accuracy_data/topk_voting/topk_catID.mat max_top1 max_top5 max_top10

save /home/hxu1/lsda/youtube_experiment/data/accuracy_data/topk_voting/topk_offsets.mat max_top1_offsets max_top5_offsets max_top10_offsets