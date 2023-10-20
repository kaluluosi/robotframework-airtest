import os
import unittest
import tempfile
from robotframework_airtest.vmg.settings import Setting
from robotframework_airtest.vmg import gen_viewmodel
from robotframework_airtest.vmg.generators.unity import UnityViewModel, generate


DEMO_PREFAB = r"tests\unity_ui\BagView.prefab"


class TestVMG(unittest.TestCase):
    def test_unity_viewmodel(self):
        model = UnityViewModel(ui_file=DEMO_PREFAB)
        self.assertTrue(model.root_node.name == "BagView")

    def test_unity_viewmodel_generator(self):
        with tempfile.TemporaryDirectory() as tmp_dir:
            output = os.path.join(tmp_dir, "BagView.resources")
            generate(DEMO_PREFAB, output)

            self.assertTrue(os.path.exists(output))

    def test_gen_viewmodel(self):
        setting = Setting(
            source="tests/unity_ui", dist="tests/dist", exts="prefab", generator="unity"
        )

        gen_viewmodel(setting=setting, name="test")

        self.assertTrue(os.path.exists(os.path.join(setting.dist, "BagView.resource")))
        self.assertTrue(
            os.path.exists(os.path.join(setting.dist, "subview", "BagView.resource"))
        )
