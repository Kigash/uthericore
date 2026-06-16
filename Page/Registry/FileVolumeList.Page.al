page 50963 "File Volume"
{
    // version TL2.0

    PageType = List;
    SourceTable = "File Volume";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Volume; Rec.Volume)
                {
                    ApplicationArea = All;
                }
                field("File Number"; Rec."File Number")
                {
                    ApplicationArea = All;
                }
                field("File Location"; Rec."File Location")
                {
                    ApplicationArea = All;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                }
                field("Previous File Number"; Rec."Previous File Number")
                {
                    Caption = 'Previous Volume';
                    ApplicationArea = All;
                }
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }
                field(MemberNo; Rec.MemberNo)
                {
                    ApplicationArea = All;
                }
                field(Volume2; Rec.Volume2)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Uncheck All")
            {
                Image = Check;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction();
                begin
                    FileVolumes.RESET;
                    FileVolumes.SETRANGE(MemberNo, Rec.MemberNo);
                    IF FileVolumes.FINDSET THEN BEGIN
                        REPEAT
                            MESSAGE('found %1 %2', FileVolumes.Volume, FileVolumes.MemberNo);
                            FileVolumes.Select := TRUE;
                        UNTIL FileVolumes.NEXT = 0;
                    END;
                end;
            }
        }
    }

    var
        FileVolumes: Record "File Volume";
}

