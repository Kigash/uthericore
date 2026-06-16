page 50764 "Supplier Evaluation Subform"
{
    PageType = ListPart;
    SourceTable = "Supplier Evaluation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Evaluation Stage"; Rec."Evaluation Stage")
                {
                    ApplicationArea = All;
                }
                field("Evaluation Code"; Rec."Evaluation Code")
                {
                    ApplicationArea = All;
                }
                field("Evaluation Description"; Rec."Evaluation Description")
                {
                    ApplicationArea = All;
                }
                field("Needs Attachment"; Rec."Needs Attachment")
                {
                    ApplicationArea = All;
                }
                field("Document Attached"; Rec."Document Attached")
                {
                    ApplicationArea = All;
                }
                field("Score(%)"; Rec."Score(%)")
                {
                    ApplicationArea = All;
                }
                field("Success Option"; Rec."Success Option")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

