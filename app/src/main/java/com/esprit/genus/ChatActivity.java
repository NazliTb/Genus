package com.esprit.genus;


import android.content.Intent;
import android.os.Bundle;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;


import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;



import com.esprit.genus.Model.Message;
import com.esprit.genus.Retrofit.INodeJS;
import com.esprit.genus.Retrofit.RetrofitClient;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.functions.Consumer;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class ChatActivity extends AppCompatActivity {


    private ChatAdapter mChatAdapter;
    private RecyclerView mRecyclerView;
    private LinearLayoutManager mLayoutManager;
    private Button mSendButton;
    private EditText mMessageEditText;
    private String username;
    private String idUser;
    private String userPic;
    private String idChat;
    CompositeDisposable compositeDisposable = new CompositeDisposable();
    INodeJS myAPI,myAPI1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_chat);
        //Recuperer les données de homepage
        Intent intent = getIntent();
        if (intent != null) {

            if (intent.hasExtra("idUser")) {
                idUser = intent.getStringExtra("idUser");
            }
            if (intent.hasExtra("username")) {
                username=intent.getStringExtra("username");
            }
            if (intent.hasExtra("userPicture")) {
               userPic=intent.getStringExtra("userPicture");

            }
            if (intent.hasExtra("idChat")) {
                idChat=intent.getStringExtra("idChat");
            }

        }


        //Init API

        Retrofit retrofit1 = RetrofitClient.getInstance();
        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl("http://10.0.2.2:3000/")
                .addConverterFactory(GsonConverterFactory.create())
                .build();



        myAPI = retrofit.create((INodeJS.class));

        myAPI1 = retrofit1.create((INodeJS.class));

        mSendButton = (Button) findViewById(R.id.button_chat_send);
        mMessageEditText = (EditText) findViewById(R.id.edittext_chat);
        mChatAdapter = new ChatAdapter(Integer.parseInt(idChat));
        mChatAdapter.loadPreviousMessages(Integer.parseInt(idChat));
        mRecyclerView = (RecyclerView) findViewById(R.id.reycler_chat);
        mLayoutManager = new LinearLayoutManager(this);
        mLayoutManager.setReverseLayout(true);
        mRecyclerView.setLayoutManager(mLayoutManager);
        mRecyclerView.setAdapter(mChatAdapter);




        mSendButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Message message=new Message(mMessageEditText.getText().toString(),new Date(),Integer.parseInt(idUser),Integer.parseInt(idChat),username,userPic);
                addMsg(mMessageEditText.getText().toString(),Integer.parseInt(idUser),Integer.parseInt(idChat));
                mChatAdapter.sendMessage(message);
                mMessageEditText.setText("");
                finish();
                startActivity(getIntent());
            }
        });

       /* mRecyclerView.addOnScrollListener(new RecyclerView.OnScrollListener() {
            @Override
            public void onScrollStateChanged(RecyclerView recyclerView, int newState) {
                if (mLayoutManager.findLastVisibleItemPosition() == mChatAdapter.getItemCount() - 1) {
                    mChatAdapter.loadPreviousMessages(Integer.parseInt(idChat));
                }
            }
        });*/

    }

    @Override
    protected void onResume() {
        super.onResume();


    }

    @Override
    protected void onPause() {

        super.onPause();

    }

    private class ChatAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {
        private static final int VIEW_TYPE_MESSAGE_SENT = 1;
        private static final int VIEW_TYPE_MESSAGE_RECEIVED = 2;

        private ArrayList<Message> mMessageList;
        private int idChat;

        ChatAdapter(int idChat) {
            mMessageList = new ArrayList<>();
            idChat=idChat;


        }



        void loadPreviousMessages(int idChat) {

            final Call<List<Message>> listMessages = myAPI.GetMsgList(idChat);
            listMessages.enqueue(new Callback<List<Message>>() {
                @Override
                public void onResponse(Call<List<Message>> call, Response<List<Message>> response) {
                    if (!response.isSuccessful()) {
                        return;
                    }
                    List<Message> msg = response.body();
                    for(Message m:msg) {

                        mMessageList.add(0, m);
                    }
                    notifyDataSetChanged();
                }
                @Override
                public void onFailure(Call<List<Message>> call, Throwable t) {
                  //  System.out.println("error");
                }
            });

        }



        // Sends a new message, and appends the sent message to the beginning of the message list.
        void sendMessage(Message message) {
            mMessageList.add(0, message);
            notifyDataSetChanged();

        }

        // Determines the appropriate ViewType according to the sender of the message.
        @Override
        public int getItemViewType(int position) {
            Message message = (Message) mMessageList.get(position);

            if (message.getIdUser()==Integer.parseInt(idUser)) {
                // If the current user is the sender of the message
                return VIEW_TYPE_MESSAGE_SENT;
            } else {
                // If some other user sent the message
                return VIEW_TYPE_MESSAGE_RECEIVED;
            }
        }

        // Inflates the appropriate layout according to the ViewType.
        @Override
        public RecyclerView.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view;

            if (viewType == VIEW_TYPE_MESSAGE_SENT) {
                view = LayoutInflater.from(parent.getContext())
                        .inflate(R.layout.item_message_received, parent, false);
                return new SentMessageHolder(view);
            } else if (viewType == VIEW_TYPE_MESSAGE_RECEIVED) {
                view = LayoutInflater.from(parent.getContext())
                        .inflate(R.layout.item_message_sent, parent, false);
                return new ReceivedMessageHolder(view);
            }

            return null;
        }

        // Passes the message object to a ViewHolder so that the contents can be bound to UI.
        @Override
        public void onBindViewHolder(RecyclerView.ViewHolder holder, int position) {
            Message message = (Message) mMessageList.get(position);

            switch (holder.getItemViewType()) {
                case VIEW_TYPE_MESSAGE_SENT:
                    ((SentMessageHolder) holder).bind(message);
                    break;
                case VIEW_TYPE_MESSAGE_RECEIVED:
                    ((ReceivedMessageHolder) holder).bind(message);
            }
        }

        @Override
        public int getItemCount() {
            return mMessageList.size();
        }

        // Messages sent by me do not display a profile image or nickname.
        private class SentMessageHolder extends RecyclerView.ViewHolder {
            TextView messageText, timeText;

            SentMessageHolder(View itemView) {
                super(itemView);

                messageText = (TextView) itemView.findViewById(R.id.text_message_body);
                timeText = (TextView) itemView.findViewById(R.id.text_message_time);

            }

            void bind(Message message) {
                messageText.setText(message.getContentMsg());

                // Format the stored timestamp into a readable String using method.
                timeText.setText(Utils.formatTime(message.getDate()));
            }
        }

        // Messages sent by others display a profile image and nickname.
        private class ReceivedMessageHolder extends RecyclerView.ViewHolder {
            TextView messageText, timeText, nameText;
            ImageView profileImage;

            ReceivedMessageHolder(View itemView) {
                super(itemView);

                messageText = (TextView) itemView.findViewById(R.id.text_message_body);
                timeText = (TextView) itemView.findViewById(R.id.text_message_time);
                nameText = (TextView) itemView.findViewById(R.id.text_message_name);
                profileImage = (ImageView) itemView.findViewById(R.id.image_message_profile);
            }

            void bind(Message message) {
                messageText.setText(message.getContentMsg());
                nameText.setText(message.getUsername());
                Utils.displayRoundImageFromUrl(ChatActivity.this,
                        "http://10.0.2.2:3000/image/"+message.getUserPicture(), profileImage);
                timeText.setText(Utils.formatTime(message.getDate()));

            }
        }


    }


    private void addMsg(String msg,int idUser,int idChat)
    {
        compositeDisposable.add(myAPI1.addMsg(msg,idUser,idChat)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Consumer<String>() {
                    @Override
                    public void accept(String s) throws Exception {
                       // System.out.println("msg sent");
                    }
                })
        );
    }

}
