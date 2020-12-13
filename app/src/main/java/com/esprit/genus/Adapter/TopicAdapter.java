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
import androidx.annotation.Nullable;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;



import com.esprit.genus.GamePictureShape.RoundRectCornerImageView;
import com.esprit.genus.Interfaces.ITopicClickListener;
import com.esprit.genus.ChatActivity;
import com.esprit.genus.Model.Chat;
import com.esprit.genus.R;
import com.sendbird.android.OpenChannel;
import com.sendbird.android.OpenChannelParams;
import com.sendbird.android.SendBirdException;


import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

public class TopicAdapter extends RecyclerView.Adapter<TopicAdapter.MyViewHolder> {

    List<Chat> chatList;
    Context mContext;
    String name;
    String idUser;
    String userPicture;
    List<String> idLists=new List<String>() {
        @Override
        public int size() {
            return 0;
        }

        @Override
        public boolean isEmpty() {
            return false;
        }

        @Override
        public boolean contains(@Nullable Object o) {
            return false;
        }

        @NonNull
        @Override
        public Iterator<String> iterator() {
            return null;
        }

        @NonNull
        @Override
        public Object[] toArray() {
            return new Object[0];
        }

        @NonNull
        @Override
        public <T> T[] toArray(@NonNull T[] a) {
            return null;
        }

        @Override
        public boolean add(String s) {
            return false;
        }

        @Override
        public boolean remove(@Nullable Object o) {
            return false;
        }

        @Override
        public boolean containsAll(@NonNull Collection<?> c) {
            return false;
        }

        @Override
        public boolean addAll(@NonNull Collection<? extends String> c) {
            return false;
        }

        @Override
        public boolean addAll(int index, @NonNull Collection<? extends String> c) {
            return false;
        }

        @Override
        public boolean removeAll(@NonNull Collection<?> c) {
            return false;
        }

        @Override
        public boolean retainAll(@NonNull Collection<?> c) {
            return false;
        }

        @Override
        public void clear() {

        }

        @Override
        public String get(int index) {
            return null;
        }

        @Override
        public String set(int index, String element) {
            return null;
        }

        @Override
        public void add(int index, String element) {

        }

        @Override
        public String remove(int index) {
            return null;
        }

        @Override
        public int indexOf(@Nullable Object o) {
            return 0;
        }

        @Override
        public int lastIndexOf(@Nullable Object o) {
            return 0;
        }

        @NonNull
        @Override
        public ListIterator<String> listIterator() {
            return null;
        }

        @NonNull
        @Override
        public ListIterator<String> listIterator(int index) {
            return null;
        }

        @NonNull
        @Override
        public List<String> subList(int fromIndex, int toIndex) {
            return null;
        }
    };

    public TopicAdapter(Context mContext, List<Chat> chatList, String name,String idUser,String userPicture) {
        this.chatList = chatList;
        this.mContext= mContext;
        this.name=name;
        this.idUser=idUser;
        this.userPicture=userPicture;
    }


    @NonNull
    @Override
    public TopicAdapter.MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View itemView = LayoutInflater.from(parent.getContext()).inflate(R.layout.gametopicitem_layout, parent, false);
        return new TopicAdapter.MyViewHolder(itemView);
    }


    @Override
    public void onBindViewHolder(@NonNull TopicAdapter.MyViewHolder holder, int position) {

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

         /*   OpenChannel.getChannel("1topic", new OpenChannel.OpenChannelGetHandler() {
                @Override
                public void onResult(OpenChannel openChannel, SendBirdException e) {
                    if (e != null) {    // Error.
                        return;
                    }
                    idLists.add(idUser);
                    OpenChannelParams params = new OpenChannelParams()
                            .setOperatorUserIds(idLists);
                    openChannel.updateChannel(params, new OpenChannel.OpenChannelUpdateHandler() {
                        @Override
                        public void onResult(OpenChannel openChannel, SendBirdException e) {
                            if (e != null) {    // Error.
                                return;
                            }
                        }
                    });;
                }

            });*/
            Intent intent;
            intent = new Intent(mContext, ChatActivity.class);
            intent.putExtra("username",name);
            intent.putExtra("idUser",idUser);
            intent.putExtra("userPicture",userPicture);
            mContext.startActivity(intent);

        }
    }

}
