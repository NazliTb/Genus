package com.esprit.genus.Adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;

import com.esprit.genus.Model.Comment;
import com.esprit.genus.R;

import org.w3c.dom.Text;

import java.util.List;

public class CommentAdapter extends RecyclerView.Adapter<CommentAdapter.MyViewHolder> {

    List<Comment> commentList;
    Context mContext;

    public CommentAdapter(Context mContext, List<Comment> gameList) {
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
        //holder.userName.setText(commentList.get(position).getIdUser());
        holder.comment.setText(commentList.get(position).getCommentText());
        holder.likesNbr.setText(commentList.get(position).getLikesNbr()+"");
    }

    @Override
    public int getItemCount() { return commentList.size(); }


    public class MyViewHolder extends RecyclerView.ViewHolder{

        CardView root_view;
        TextView userName, comment, likesNbr;

        public MyViewHolder(@NonNull View itemView) {
            super(itemView);
            mContext = itemView.getContext();

            root_view = (CardView) itemView.findViewById(R.id.root_view);
            //userName = (TextView) itemView.findViewById(R.id.txt_name);
            comment = (TextView) itemView.findViewById(R.id.txt_comment);
            likesNbr = (TextView) itemView.findViewById(R.id.txt_likes);
        }
    }
}
