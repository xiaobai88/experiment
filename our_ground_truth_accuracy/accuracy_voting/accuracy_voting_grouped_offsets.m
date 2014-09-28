clear all
close all

load /home/hxu1/lsda/youtube_experiment/data/accuracy_data/ground_truth_offsets_grouped.mat;
load /home/hxu1/lsda/youtube_experiment/data/accuracy_data/topk_voting/topk_offsets.mat;

% compute binary accuracy
max_top1_accuracy=binary_accuracy(ground_truth_offsets_grouped,max_top1_offsets);
max_top5_accuracy=binary_accuracy(ground_truth_offsets_grouped,max_top5_offsets);
max_top10_accuracy=binary_accuracy(ground_truth_offsets_grouped,max_top10_offsets);


fprintf('\nmax_top1_accuracy: %.3f',max_top1_accuracy);
fprintf('\nmax_top5_accuracy: %.3f',max_top5_accuracy);
fprintf('\nmax_top10_accuracy: %.3f\n',max_top10_accuracy);
