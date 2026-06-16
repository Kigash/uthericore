page 55721 "File Request Trail"
{
    // version CBS-TL,REG

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "File Requests Trail";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request ID"; Rec."Request ID")
                {
                }
                field("Request No."; Rec."Request No.")
                {
                }
                field(Requester; Rec.Requester)
                {
                }
                field("Request Date"; Rec."Request Date")
                {
                }
                field("Approval Date"; Rec."Approval Date")
                {
                }
                field("Approver ID"; Rec."Approver ID")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approve)
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = SeeApprovals;

                trigger OnAction();
                begin
                    IF CONFIRM('Are you sure you want to approve?') THEN BEGIN
                        Rec."Approver ID" := USERID;
                        Rec."Approval Date" := TODAY;
                        IssuedRegistryFiles.RESET;
                        IssuedRegistryFiles.SETRANGE("Request ID", Rec."Request ID");
                        IF IssuedRegistryFiles.FINDSET THEN BEGIN
                            RegistryFilesLines.RESET;
                            RegistryFilesLines.SETRANGE("Request ID", IssuedRegistryFiles."Request ID");
                            IF RegistryFilesLines.FINDSET THEN BEGIN
                                REPEAT
                                    RegistryFilesLines."Other User" := Rec.Requester;
                                    RegistryFilesLines.MODIFY;
                                    Rec."File Transferred" := TRUE;
                                    Rec.MODIFY;
                                UNTIL RegistryFilesLines.NEXT = 0;
                            END;
                        END;
                        MESSAGE('Approval Successful');
                    END;
                end;
            }
            action(Reject)
            {
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = SeeApprovals;
            }
        }
    }

    trigger OnOpenPage();
    begin
        IssuedRegistryFiles.RESET;
        IssuedRegistryFiles.SETRANGE("Request ID", Rec."Request ID");
        IF IssuedRegistryFiles.FINDSET THEN BEGIN
            IF IssuedRegistryFiles."Request ID" <> '' THEN BEGIN
                SeeApprovals := TRUE;
            END;
        END;
    end;

    var
        SeeApprovals: Boolean;
        IssuedRegistryFiles: Record "Issued Registry File";
        RegistryFilesLines: Record "Registry Files Line";
}

