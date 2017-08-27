import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQml.Models 2.2

DelegateModel {
    id: filterModel

    property var condition: function(entry) { return true; }

    Component.onCompleted: updateFilters()

    function updateFilters() {
        for(var i=0; i<model.count; ++i) {
            var entry = model.get(i);

            if(condition(entry)) {
                items.addGroups(i,1,["match"]);
            } else {
                items.removeGroups(i,1,["match"])
            }
        }
    }

    groups: [
        DelegateModelGroup {
            id: matchGroup
            name: "match"
            includeByDefault: false
        }
    ]

    filterOnGroup: "match"
}
