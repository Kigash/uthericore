page 55705 "Registry Approvals"
{
    // version CBS-TL,REG

    PageType = List;
    SourceTable = "Registry Requests Approval";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = All;
                }
                field("HOD Approval"; Rec."HOD Approval")
                {
                    ApplicationArea = All;
                }
                field("HOD Approver"; Rec."HOD Approver")
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

