clear all
close all

load /home/hxu1/lsda/youtube_experiment/data/accuracy_data/ground_truth_offsets_original.mat;
load /home/hxu1/lsda/youtube_experiment/data/accuracy_data/topk_tracklets/topk_offsets.mat;

% compute binary accuracy
max_top1_accuracy=binary_accuracy(ground_truth_offsets_original,max_top1_offsets);
max_top5_accuracy=binary_accuracy(ground_truth_offsets_original,max_top5_offsets);
max_top10_accuracy=binary_accuracy(ground_truth_offsets_original,max_top10_offsets);

avg0_top1_accuracy=binary_accuracy(ground_truth_offsets_original,avg0_top1_offsets);
avg0_top5_accuracy=binary_accuracy(ground_truth_offsets_original,avg0_top5_offsets);
avg0_top10_accuracy=binary_accuracy(ground_truth_offsets_original,avg0_top10_offsets);

avg1_top1_accuracy=binary_accuracy(ground_truth_offsets_original,avg1_top1_offsets);
avg1_top5_accuracy=binary_accuracy(ground_truth_offsets_original,avg1_top5_offsets);
avg1_top10_accuracy=binary_accuracy(ground_truth_offsets_original,avg1_top10_offsets);


fprintf('\nmax_top1_accuracy: %.3f',max_top1_accuracy);
fprintf('\nmax_top5_accuracy: %.3f',max_top5_accuracy);
fprintf('\nmax_top10_accuracy: %.3f',max_top10_accuracy);
fprintf('\n\navg0_top1_accuracy: %.3f',avg0_top1_accuracy);
fprintf('\navg0_top5_accuracy: %.3f',avg0_top5_accuracy);
fprintf('\navg0_top10_accuracy: %.3f',avg0_top10_accuracy);
fprintf('\n\navg1_top1_accuracy: %.3f',avg1_top1_accuracy);
fprintf('\navg1_top5_accuracy: %.3f',avg1_top5_accuracy);
fprintf('\navg1_top10_accuracy: %.3f\n',avg1_top10_accuracy);


% compute recall average
max_top1_recall_avg=recall_average(ground_truth_offsets_original,max_top1_offsets);
max_top5_recall_avg=recall_average(ground_truth_offsets_original,max_top5_offsets);
max_top10_recall_avg=recall_average(ground_truth_offsets_original,max_top10_offsets);

avg0_top1_recall_avg=recall_average(ground_truth_offsets_original,avg0_top1_offsets);
avg0_top5_recall_avg=recall_average(ground_truth_offsets_original,avg0_top5_offsets);
avg0_top10_recall_avg=recall_average(ground_truth_offsets_original,avg0_top10_offsets);

avg1_top1_recall_avg=recall_average(ground_truth_offsets_original,avg1_top1_offsets);
avg1_top5_recall_avg=recall_average(ground_truth_offsets_original,avg1_top5_offsets);
avg1_top10_recall_avg=recall_average(ground_truth_offsets_original,avg1_top10_offsets);


fprintf('\nmax_top1_recall_avg: %.3f',max_top1_recall_avg);
fprintf('\nmax_top5_recall_avg: %.3f',max_top5_recall_avg);
fprintf('\nmax_top10_recall_avg: %.3f',max_top10_recall_avg);
fprintf('\n\navg0_top1_recall_avg: %.3f',avg0_top1_recall_avg);
fprintf('\navg0_top5_recall_avg: %.3f',avg0_top5_recall_avg);
fprintf('\navg0_top10_recall_avg: %.3f',avg0_top10_recall_avg);
fprintf('\n\navg1_top1_recall_avg: %.3f',avg1_top1_recall_avg);
fprintf('\navg1_top5_recall_avg: %.3f',avg1_top5_recall_avg);
fprintf('\navg1_top10_recall_avg: %.3f\n',avg1_top10_recall_avg);
