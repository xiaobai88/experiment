clear all;
close all;

load /home/hxu1/lsda/youtube_experiment/per_frame_box_cats/feature/rcnn_detectors_scores.mat;
synset_words_200 = importdata('/home/hxu1/lsda/youtube_experiment/data/synset_words_data/det_synset_words.txt');
synset_words_7400 = importdata('/home/hxu1/lsda/youtube_experiment/data/synset_words_data/imagenet7k_wnids_full_labels.txt');
load /home/hxu1/lsda/data/rcnn_models/rcnn_model7200.mat;
fprintf('Load Data Finish\n');

% max over all 7.6k features and take max
max_top1=cell(1,1970);
max_top5=cell(1,1970);
max_top10=cell(1,1970);
max_vid_scores=cell(1,1970);

for i = 1:1970
    max_vid_scores{i} = cat(1,rcnn_detectors_scores{i}{:});
    for j = 1:10
        [x,y] = find(max_vid_scores{i} == max(max(max_vid_scores{i})));
        max_vid_scores{i}(x(1),y(1))=0;
        if j==1
            max_top1{i} = y(1);
        end
        if j<=5
            max_top5{i}(j) = y(1);
        end
        max_top10{i}(j) = y(1);
    end
end

% average over all 7.6k features and take max
th = 0;
avg_top1=cell(1,1970);
avg_top5=cell(1,1970);
avg_top10=cell(1,1970);
avg_vid_scores=cell(1,1970);

for i = 1:1970
    for j = 1:length(rcnn_detectors_scores{i})
        rcnn_detectors_scores{i}{j}(find(rcnn_detectors_scores{i}{j}<th))=0;
    end
    avg_vid_scores{i} = mean(cat(1,rcnn_detectors_scores{i}{:}));
    [x, y]=sort(avg_vid_scores{i},'descend');
    avg_top1_index = min(1,max(find(x>0)));
    avg_top1{i}=y(avg_top1_index);
    avg_top5_index = min(5,max(find(x>0)));
    avg_top5{i}=y(1:avg_top5_index);    
    avg_top10_index = min(10,max(find(x>0)));
    avg_top10{i}=y(1:avg_top10_index);
end
fprintf('Cats Index Finish\n');

% Obtain top 1/5/10 cats
max_top1_cats=cell(1,1970);
max_top5_cats=cell(1,1970);
max_top10_cats=cell(1,1970);

avg_top1_cats=cell(1,1970);
avg_top5_cats=cell(1,1970);
avg_top10_cats=cell(1,1970);

for i=1:1970,
    cats_ids = max_top1{i};
    max_top1_cats{i} = rcnn_model.classes(cats_ids);
    cats_ids = max_top5{i};
    max_top5_cats{i} = rcnn_model.classes(cats_ids);
    cats_ids = max_top10{i};
    max_top10_cats{i} = rcnn_model.classes(cats_ids);

    cats_ids = avg_top1{i};
    avg_top1_cats{i} = rcnn_model.classes(cats_ids);
    cats_ids = avg_top5{i};
    avg_top5_cats{i} = rcnn_model.classes(cats_ids);
    cats_ids = avg_top10{i};
    avg_top10_cats{i} = rcnn_model.classes(cats_ids);
end
fprintf('Cats ID Finish\n');

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

        cats_ids = avg_top1{i};
        avg_top1_offsets{i} = offsets_7600(cats_ids);
        cats_ids = avg_top5{i};
        avg_top5_offsets{i} = offsets_7600(cats_ids);
        cats_ids = avg_top10{i};
        avg_top10_offsets{i} = offsets_7600(cats_ids);
end
fprintf('Offsets Finish\n');

save /home/hxu1/lsda/youtube_experiment/data/accuracy_data/topk_from_7k6/topk_cats_7k6.mat max_top1_cats max_top5_cats max_top10_cats avg_top1_cats avg_top5_cats avg_top10_cats 

save /home/hxu1/lsda/youtube_experiment/data/accuracy_data/topk_from_7k6/topk_catID_7k6.mat max_top1 max_top5 max_top10 avg_top1 avg_top5 avg_top10 

save /home/hxu1/lsda/youtube_experiment/data/accuracy_data/topk_from_7k6/topk_offsets_7k6.mat max_top1_offsets max_top5_offsets max_top10_offsets avg_top1_offsets avg_top5_offsets avg_top10_offsets