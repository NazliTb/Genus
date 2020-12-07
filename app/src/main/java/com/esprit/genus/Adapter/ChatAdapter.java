package com.esprit.genus.Adapter;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;


import com.bumptech.glide.Glide;
import com.esprit.genus.ChatListActivity;
import com.esprit.genus.GamePictureShape.RoundRectCornerImageView;
import com.esprit.genus.Interfaces.ITopicClickListener;
import com.esprit.genus.Model.Chat;
import com.esprit.genus.R;


import java.util.List;

public class ChatAdapter extends RecyclerView.Adapter<ChatAdapter.MyViewHolder> {

    List<Chat> chatList;
    Context mContext;

    public ChatAdapter(Context mContext,List<Chat> chatList) {
        this.chatList = chatList;
        this.mContext= mContext;
    }

    @NonNull
    @Override
    public ChatAdapter.MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View itemView = LayoutInflater.from(parent.getContext()).inflate(R.layout.gametopicitem_layout, parent, false);
        return new ChatAdapter.MyViewHolder(itemView);
    }


    @Override
    public void onBindViewHolder(@NonNull ChatAdapter.MyViewHolder holder, int position) {
      //  Glide.with(mContext).load("http://10.0.2.2:3000/image/"+gameList.get(position).getGamePicture()).into(holder.gamePic);
        holder.topicDate.setText(chatList.get(position).getDate().toString());
        holder.topic.setText(chatList.get(position).getTopic());
        //holder.membersNumber
        holder.username.setText(chatList.get(position).getUsername());

        holder.setTopicClickListener(new ITopicClickListener() {
            @Override
            public void onTopicClick(View view, int position) {
                Toast.makeText(mContext, ""+chatList.get(position).getTopic(), Toast.LENGTH_SHORT).show();
            }
        });
    }

    @Override
    public int getItemCount() {
        return chatList.size();
    }

    public class MyViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {

        CardView root_view;
        TextView topic,membersNumber,topicDate,username;
        RoundRectCornerImageView topicPic;
        Button btnJoin;

        ITopicClickListener topicClickListener;

        public void setTopicClickListener(ITopicClickListener topicClickListener) {
            this.topicClickListener = topicClickListener;
        }

        public MyViewHolder(@NonNull View itemView) {
            super(itemView);
            mContext = itemView.getContext();

            root_view = (CardView) itemView.findViewById(R.id.root_view);
            topicPic = (RoundRectCornerImageView) itemView.findViewById(R.id.topicPic);
            topic = (TextView) itemView.findViewById(R.id.topic);
            membersNumber = (TextView) itemView.findViewById(R.id.membersNumber);
            topicDate = (TextView) itemView.findViewById(R.id.topicDate);
            username = (TextView) itemView.findViewById(R.id.username);
            btnJoin = (Button) itemView.findViewById(R.id.btnJoin);

            itemView.setOnClickListener(this);

        }

        @Override
        public void onClick(View v) {
           topicClickListener.onTopicClick(v, getAdapterPosition());
            Intent intent;
            intent = new Intent(mContext, ChatListActivity.class);
            mContext.startActivity(intent);
        }
    }

}
