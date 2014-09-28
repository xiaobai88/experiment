clear all;
close all;

load /home/hxu1/lsda/youtube_experiment/code/smooth_tracklets/rcnn_detectors_scores_result/rcnn_tracks_with_cats.mat;
synset_words_200 = importdata('/home/hxu1/lsda/youtube_experiment/data/synset_words_data/det_synset_words.txt');
synset_words_7400 = importdata('/home/hxu1/lsda/youtube_experiment/data/synset_words_data/imagenet7k_wnids_full_labels.txt');
load /home/hxu1/lsda/data/rcnn_models/rcnn_model7200.mat;
fprintf('Load Data Finish\n');

% get the scores and cats for each track in each video
track_scores_cats=cell(1,1970);
for k =1:length(rcnn_tracks_with_cats)
    track_scores_cats{k} = [];
    for j =1:length(rcnn_tracks_with_cats{k})
        track_scores_cats{k} = [track_scores_cats{k}; rcnn_tracks_with_cats{k}{j}(1,[3:4])];
    end
end

% take the topk max catID
max_top1=cell(1,length(track_scores_cats));
max_top5=cell(1,length(track_scores_cats));
max_top10=cell(1,length(track_scores_cats));

for k =1:length(track_scores_cats)
    if size(track_scores_cats{k},1) == 0
        max_top1{k} = [];
        max_top5{k} = [];
        max_top10{k} = [];
    else
        [x, y]=sort(track_scores_cats{k}(:,1),'descend');
        track_num = length(x);

        max_top1{k} = track_scores_cats{k}(y(1),2)';
       
        index = min(5,track_num);
        max_top5{k} = track_scores_cats{k}(y(1:index),2)';
        
        index = min(10,track_num);
        max_top10{k} = track_scores_cats{k}(y(1:index),2)';
    end
end

% average and take max
avg0_track_scores_cats=cell(1,1970); % average over all bbs
avg1_track_scores_cats=cell(1,1970); % average over the same cats
avg0_top1=cell(1,1970);
avg0_top5=cell(1,1970);
avg0_top10=cell(1,1970);
avg1_top1=cell(1,1970);
avg1_top5=cell(1,1970);
avg1_top10=cell(1,1970);

% calculate two kinds of average
for i=1:length(track_scores_cats)
    if size(track_scores_cats{i},1) == 0
        avg0_track_scores_cats{i} = [];
        avg1_track_scores_cats{i} = [];
    else
        total_cats_per_vid=unique(track_scores_cats{i}(:,2));
        for j =1:length(total_cats_per_vid),
            x_temp=find(track_scores_cats{i}(:,2)==total_cats_per_vid(j));
            avg0_track_scores_cats{i}= [avg0_track_scores_cats{i};[sum(track_scores_cats{i}(x_temp,1)) / length(track_scores_cats{i}(:,2)),total_cats_per_vid(j)]];
            avg1_track_scores_cats{i}= [avg1_track_scores_cats{i};[sum(track_scores_cats{i}(x_temp,1)) / length(x_temp),total_cats_per_vid(j)]];
        end
    end
end

% get top1,top5,top10 after average
for i=1:1970
    if size(track_scores_cats{i},1) == 0
        avg0_top1{i} = [];
        avg0_top5{i} = [];
        avg0_top10{i} = [];
        avg1_top1{i} = [];
        avg1_top5{i} = [];
        avg1_top10{i} = [];
    else
        [x, y]=sort(avg0_track_scores_cats{i}(:,1),'descend');
        avg0_top1{i}=avg0_track_scores_cats{i}(y(1),2)';
        index=min(5,length(y));
        avg0_top5{i}=avg0_track_scores_cats{i}(y(1:index),2)';
        index=min(10,length(y));
        avg0_top10{i}=avg0_track_scores_cats{i}(y(1:index),2)';
        
        [x1, y1]=sort(avg1_track_scores_cats{i}(:,1),'descend');
        avg1_top1{i}=avg1_track_scores_cats{i}(y1(1),2)';
        index=min(5,length(y1));
        avg1_top5{i}=avg1_track_scores_cats{i}(y1(1:index),2)';
        index=min(10,length(y1));
        avg1_top10{i}=avg1_track_scores_cats{i}(y1(1:index),2)';
    end
end

fprintf('Cats Index Finish\n');

% Obtain top 1/5/10 cats
max_top1_cats=cell(1,1970);
max_top5_cats=cell(1,1970);
max_top10_cats=cell(1,1970);

avg0_top1_cats=cell(1,1970);
avg0_top5_cats=cell(1,1970);
avg0_top10_cats=cell(1,1970);

avg1_top1_cats=cell(1,1970);
avg1_top5_cats=cell(1,1970);
avg1_top10_cats=cell(1,1970);

for i=1:1970,
    cats_ids = max_top1{i};
    max_top1_cats{i} = rcnn_model.classes(cats_ids);
    cats_ids = max_top5{i};
    max_top5_cats{i} = rcnn_model.classes(cats_ids);
    cats_ids = max_top10{i};
    max_top10_cats{i} = rcnn_model.classes(cats_ids);

    cats_ids = avg0_top1{i};
    avg0_top1_cats{i} = rcnn_model.classes(cats_ids);
    cats_ids = avg0_top5{i};
    avg0_top5_cats{i} = rcnn_model.classes(cats_ids);
    cats_ids = avg0_top10{i};
    avg0_top10_cats{i} = rcnn_model.classes(cats_ids);

    cats_ids = avg1_top1{i};
    avg1_top1_cats{i} = rcnn_model.classes(cats_ids);
    cats_ids = avg1_top5{i};
    avg1_top5_cats{i} = rcnn_model.classes(cats_ids);
    cats_ids = avg1_top10{i};
    avg1_top10_cats{i} = rcnn_model.classes(cats_ids);
end
fprintf('Cats Finish\n');

% get offsets mapping
offsets_200 = {};
for k=1:length(synset_words_200)
    offsets_200{k} = synset_words_200{k}(1:9);
end

offsets_7400 = {};
for k=1:length(synset_words_7400)
    offsets_7400{k} = synset_words_7400{k}(1:9);
end

offsets_7600 = [offsets_200,offsets_7400];

% get the topk offsets for each vid
max_top1_offsets=cell(1,1970);
max_top5_offsets=cell(1,1970);
max_top10_offsets=cell(1,1970);

avg0_top1_offsets=cell(1,1970);
avg0_top5_offsets=cell(1,1970);
avg0_top10_offsets=cell(1,1970);

avg1_top1_offsets=cell(1,1970);
avg1_top5_offsets=cell(1,1970);
avg1_top10_offsets=cell(1,1970);

for i=1:1970,
    cats_ids = max_top1{i};
    max_top1_offsets{i} = offsets_7600(cats_ids);
    cats_ids = max_top5{i};
    max_top5_offsets{i} = offsets_7600(cats_ids);
    cats_ids = max_top10{i};
    max_top10_offsets{i} = offsets_7600(cats_ids);
    
    cats_ids = avg0_top1{i};
    avg0_top1_offsets{i} = offsets_7600(cats_ids);
    cats_ids = avg0_top5{i};
    avg0_top5_offsets{i} = offsets_7600(cats_ids);
    cats_ids = avg0_top10{i};
    avg0_top10_offsets{i} = offsets_7600(cats_ids);
    
    cats_ids = avg1_top1{i};
    avg1_top1_offsets{i} = offsets_7600(cats_ids);
    cats_ids = avg1_top5{i};
    avg1_top5_offsets{i} = offsets_7600(cats_ids);
    cats_ids = avg1_top10{i};
    avg1_top10_offsets{i} = offsets_7600(cats_ids);
end
fprintf('Offsets Finish\n');

save /home/hxu1/lsda/youtube_experiment/data/accuracy_data/topk_tracklets/topk_cats.mat max_top1_cats max_top5_cats max_top10_cats avg0_top1_cats avg0_top5_cats avg0_top10_cats avg1_top1_cats avg1_top5_cats avg1_top10_cats

save /home/hxu1/lsda/youtube_experiment/data/accuracy_data/topk_tracklets/topk_catID.mat max_top1 max_top5 max_top10 avg0_top1 avg0_top5 avg0_top10 avg1_top1 avg1_top5 avg1_top10

save /home/hxu1/lsda/youtube_experiment/data/accuracy_data/topk_tracklets/topk_offsets.mat max_top1_offsets max_top5_offsets max_top10_offsets avg0_top1_offsets avg0_top5_offsets avg0_top10_offsets avg1_top1_offsets avg1_top5_offsets avg1_top10_offsets