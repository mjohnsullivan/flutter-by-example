package io.flutter.addfluttertoapp

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.annotation.NonNull
import com.google.android.material.bottomnavigation.BottomNavigationView
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.android.FlutterFragment
import kotlinx.android.synthetic.main.activity_main.*


class MainActivity : AppCompatActivity() {

    private val mOnNavigationItemSelectedListener = BottomNavigationView.OnNavigationItemSelectedListener { item ->
        // removeAllFragments()
        when (item.itemId) {
            R.id.navigation_home -> {
                addFragment(null, "I am an Android Fragment!!!")
                return@OnNavigationItemSelectedListener true
            }
            R.id.navigation_dashboard -> {
                addFragment(null, "I am a second Android Fragment!!!")
                return@OnNavigationItemSelectedListener true
            }
            R.id.navigation_notifications -> {
                addFlutterFragment()
                return@OnNavigationItemSelectedListener true
            }
        }
        false
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        addFragment(null, "I am an Android Fragment!!!")

        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener)
    }

    private fun addFragment(savedInstanceState: Bundle?, text: String) {
        if (savedInstanceState == null) {
            supportFragmentManager
                .beginTransaction()
                .replace(R.id.fragment_container,
                    AndroidFragment.newInstance(text))
                .commit()
        }
    }


    private fun addFlutterFragment() {
        supportFragmentManager.beginTransaction()
            .replace(R.id.fragment_container,
                     MyFlutterFragment.newInstance())
            .commit()
    }
}


class AndroidFragment : Fragment() {

    companion object {
        fun newInstance(text: String): AndroidFragment {
            val fragment = AndroidFragment()
            val args = Bundle()
            args.putString("text", text)
            fragment.arguments = args
            return fragment
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_main, container, false)
        arguments?.getString("text").let {
            view.findViewById<TextView>(R.id.fragment_message).setText(it)
        }
        return view
    }
}

class MyFlutterFragment : FlutterFragment() {

    companion object {
        fun newInstance(): FlutterFragment {
            val fragment = MyFlutterFragment()
            fragment.arguments = FlutterFragment.createArgsBundle(null, null, null, null)
            return fragment
        }
    }

    override fun onCreateFlutterEngine(@NonNull context: Context): FlutterEngine {
        val app = context.applicationContext as MyApplication
        return app.engine
    }

    override fun retainFlutterIsolateAfterFragmentDestruction() : Boolean {
        return true
    }
}