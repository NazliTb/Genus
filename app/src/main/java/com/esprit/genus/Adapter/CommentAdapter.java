package com.esprit.genus.Adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.esprit.genus.Model.Comment;
import com.esprit.genus.R;

import java.util.List;

public class CommentAdapter extends RecyclerView.Adapter<CommentAdapter.MyViewHolder> {

    List<Comment> commentList;
    Context mContext;

    public CommentAdapter(List<Comment> gameList, Context mContext) {
        this.commentList = gameList;
        this.mContext = mContext;
    }

    @NonNull
    @Override
    public MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View itemView = LayoutInflater.from(parent.getContext()).inflate(R.layout.comment_layout, parent, false);
        return new MyViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(@NonNull MyViewHolder holder, int position) {

    }

    @Override
    public int getItemCount() { return commentList.size(); }


    public class MyViewHolder extends RecyclerView.ViewHolder{
        public MyViewHolder(@NonNull View itemView) {
            super(itemView);
        }
    }
}
