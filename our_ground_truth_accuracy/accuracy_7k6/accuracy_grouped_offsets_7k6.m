clear all
close all

load /home/hxu1/lsda/youtube_experiment/data/accuracy_data/ground_truth_offsets_grouped.mat;
load /home/hxu1/lsda/youtube_experiment/data/accuracy_data/topk_from_7k6/topk_offsets_7k6.mat;

% compute binary accuracy
max_top1_accuracy=binary_accuracy(ground_truth_offsets_grouped,max_top1_offsets);
max_top5_accuracy=binary_accuracy(ground_truth_offsets_grouped,max_top5_offsets);
max_top10_accuracy=binary_accuracy(ground_truth_offsets_grouped,max_top10_offsets);

avg_top1_accuracy=binary_accuracy(ground_truth_offsets_grouped,avg_top1_offsets);
avg_top5_accuracy=binary_accuracy(ground_truth_offsets_grouped,avg_top5_offsets);
avg_top10_accuracy=binary_accuracy(ground_truth_offsets_grouped,avg_top10_offsets);

fprintf('binary accuracy:\n')
fprintf('max_top1_accuracy: %.3f\n',max_top1_accuracy);
fprintf('max_top5_accuracy: %.3f\n',max_top5_accuracy);
fprintf('max_top10_accuracy: %.3f\n\n',max_top10_accuracy);
fprintf('avg_top1_accuracy: %.3f\n',avg_top1_accuracy);
fprintf('avg_top5_accuracy: %.3f\n',avg_top5_accuracy);
fprintf('avg_top10_accuracy: %.3f\n\n',avg_top10_accuracy);

% compute recall average
max_top1_recall_avg=recall_average(ground_truth_offsets_grouped,max_top1_offsets);
max_top5_recall_avg=recall_average(ground_truth_offsets_grouped,max_top5_offsets);
max_top10_recall_avg=recall_average(ground_truth_offsets_grouped,max_top10_offsets);

avg_top1_recall_avg=recall_average(ground_truth_offsets_grouped,avg_top1_offsets);
avg_top5_recall_avg=recall_average(ground_truth_offsets_grouped,avg_top5_offsets);
avg_top10_recall_avg=recall_average(ground_truth_offsets_grouped,avg_top10_offsets);

fprintf('recall average:\n')
fprintf('max_top1_recall_avg: %.3f\n',max_top1_recall_avg);
fprintf('max_top5_recall_avg: %.3f\n',max_top5_recall_avg);
fprintf('max_top10_recall_avg: %.3f\n\n',max_top10_recall_avg);
fprintf('avg_top1_recall_avg: %.3f\n',avg_top1_recall_avg);
fprintf('avg_top5_recall_avg: %.3f\n',avg_top5_recall_avg);
fprintf('avg_top10_recall_avg: %.3f\n\n',avg_top10_recall_avg);